<cfcomponent output="true">

	<cfset oData 		= createObject( 'component', 'interview.Larry.indexData' )>
	<cfset oRenderer  	= createObject( 'component', 'interview.Larry.indexRenderer' )>
	<cfset oSession 	= createObject( 'component', 'interview.Larry.sessionController' )>

	<cffunction name="fetchHeader" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#"> 

		<cfset var CurrentUser 				= structNew( )>
		
		<cfset CurrentUser 					= oSession.fetchCurrentUser( )>

		<cfoutput>
			#oRenderer.renderHeader( FormData, CurrentUser )#
		</cfoutput>	
		
	</cffunction>

	<cffunction name="fetchFooter" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfset var CurrentUser = structNew( )>
		
		<cfset CurrentUser = oSession.fetchCurrentUser( )>

		<cfoutput>
			#oRenderer.renderFooter( FormData, CurrentUser )#
		</cfoutput>	

	</cffunction>

	<cffunction name="fetchHome" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var CurrentUser 	= structNew( );
			var CurrentProject 	= structNew( );
			var HomeData 		= queryNew( '' );

			CurrentUser 	= oSession.fetchCurrentUser( );
			CurrentProject 	= oSession.fetchProject( );
			HomeData 		= oData.getHome( CurrentUser[ 'UserNumber' ], CurrentUser[ 'UsersManaged' ], CurrentProject[ 'ProjectNumber' ] );

			oRenderer.renderHome( FormData, HomeData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchUsers" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var UserData 	= queryNew( '' );

			UsersData 		= oData.getUsers( );

			oRenderer.renderUsers( UsersData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchUser" returntype="void" output="true">
		<cfargument 	name="FormData" required="false" default="#structNew( )#">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var CurrentUser = structNew(  );
			var UserData 	= queryNew( '' );

			CurrentUser 	= oSession.fetchCurrentUser(  );
			UserData 		= oData.getUser( CurrentUser[ 'UserNumber' ], IsAjax );
			oRenderer.renderUser(  );

		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessUser" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 			= queryNew( '' );
			var SelectedUser 		= queryNew( '' );
			var ManagedUsers 		= queryNew( '' );
			var ManagedUsersList  	= '';

			SelectedUser 		= oData.getUser( FormData[ 'UserId' ], IsAjax );
			ManagedUsers 		= oData.getManagedUsers( FormData[ 'UserId' ] );
			ManagedUsersList 	= valueList( ManagedUsers.UserNumber );

			oSession.storeCurrentUser( SelectedUser, ManagedUsersList );
			location( '?a=home', false );


		</cfscript>

	</cffunction>

	<cffunction name="fetchProjects" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var ProjectData =  oData.getProjects( );
			oRenderer.renderProjects( ProjectData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessProject" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var SelectedProject 	= queryNew( '' );

			SelectedProject 		= oData.getProject( FormData[ 'Project' ], IsAjax );

			oSession.storeProject( SelectedProject );
			location( '?a=home', false );

		</cfscript>

	</cffunction>

	<cffunction name="fetchAddHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var CurrentUser 		= oSession.fetchCurrentUser(  );
			var CurrentProject 		= oSession.fetchProject(  );

			oRenderer.renderAddHours( FormData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessAddHours" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 			= queryNew( '' );
			var CurrentUser 		= oSession.fetchCurrentUser(  );
			var CurrentProject 		= oSession.fetchProject(  );

			if( IsNumeric( FormData[ 'UserId' ] ) AND ( FormData[ 'UserId' ] EQ CurrentUser[ 'UserNumber' ] ) OR ( FormData[ 'UserId' ] EQ CurrentUser[ 'Supervisor' ] ) ){

				Results 			= oData.addHours( FormData, CurrentUser, CurrentProject );

				if( Results ){

					location( '?a=home&success=1', false );

				} else {

					location( '?a=home&success=0', false );

				}

			} else {

				location( '?a=home&success=0', false );

			}

		</cfscript>

	</cffunction>

	<cffunction name="fetchEditHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var Results 			= queryNew( '' );
			var CurrentUser 		= oSession.fetchCurrentUser(  );
			var CurrentProject 		= oSession.fetchProject(  );

			oRenderer.renderEditHours( FormData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessEditHours" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 			= queryNew( '' );
			var CurrentUser 		= oSession.fetchCurrentUser(  );
			var CurrentProject 		= oSession.fetchProject(  );

			if( IsNumeric( FormData[ 'UserId' ] ) AND ( FormData[ 'UserId' ] EQ CurrentUser[ 'UserNumber' ] ) OR ( FormData[ 'UserId' ] EQ CurrentUser[ 'Supervisor' ] ) ){

				Results 			= oData.editHours( FormData );

				if( Results ){
					location( '?a=home&success=1', false );
				} else{
					location( '?a=home&success=0', false );
				}

			} else {
				location( '?a=home&success=0', false );
			}

		</cfscript>
	</cffunction>

</cfcomponent>