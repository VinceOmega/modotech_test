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

			var CurrentUser = structNew( );
			var HomeData 	= queryNew( '' );
			CurrentUser 	= oSession.fetchCurrentUser( );
			HomeData 		= oData.getHome( CurrentUser[ 'UserNumber' ] );
			oRenderer.renderHome( FormData, HomeData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchUsers" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>

			var CurrentUser = structNew( );
			var UserData 	= queryNew( '' );
			CurrentUser 	= oSession.fetchCurrentUser( );
			UsersData 		= oData.getUsers( );
			oRenderer.renderUsers( UsersData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchUser" returntype="void" output="true">
		<cfargument 	name="FormData" required="false" default="#structNew( )#">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var CurrentUser = structNew( );
			var UserData 	= queryNew( '' );
			CurrentUser 	= oSession.fetchCurrentUser( );
			UserData 		= oData.getUser( CurrentUser[ 'UserNumber' ], IsAjax );
			oRenderer.renderUser( );

		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessUser" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 		= structNew(  );
			var SelectedUser 	= structNew(  );
			var ManagedUsers 	= structNew(  );

			SelectedUser 		= oData.getUser( FormData[ 'User' ], IsAjax );
			ManagedUsers 		= oData.getManagedUsers( FormData[ 'User' ] );

			oSession.storeCurrentUser( SelectedUser, ManagedUsers );
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

			var Results 			= structNew(  );
			var SelectedProject 	= structNew(  );

			SelectedProject 		= oData.getProject( FormData[ 'Project' ], IsAjax );
			Results 				= oData.setProject( FormData[ 'Project' ] );

			oSession.storeProject( SelectedProject );
			location( '?a=home', false );

		</cfscript>

	</cffunction>

	<cffunction name="fetchAddHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessAddHours" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 			= structNew(  );
			var CurrentUser 		= oSession.fetchCurrentUser( );
			var CurrentProject 		= oSession.fetch

			Results 				= oData.addHours( FormData[ 'Project' ] );

			if( Results ){
				location( '?a=home&success=1', false );
			} else {
				location( '?a=home', false );
			}

		</cfscript>
	</cffunction>

	<cffunction name="fetchEditHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchProcessEditHours" returntype="void" output="true">
		<cfargument 	name="FormData" required="true">
		<cfargument 	name="IsAjax" 	required="false" default="0">

		<cfscript>

			var Results 			= structNew(  );

			Results 				= oData.setEditHours( FormData[ 'Project' ] );

			if( Results ){
				oData.storeProject( SelectedProject );
				location( '?a=home&success=1', false );
			} else {
				location( '?a=home', false );
			}

		</cfscript>
	</cffunction>

</cfcomponent>