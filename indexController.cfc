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
			#oRenderer.renderHeader( FormData, CurrentUser )#
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
			UserData 		= oData.getUsers( );
			oRenderer.renderUsers( FormData, UserData );

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


	<cffunction name="fetchProject" returntype="void" output="true">
		<cfargument name="ProjectId" required="false" default="#structNew( )#">

		<cfscript>

			var ProjectData =  oData.getProject( ProjectId );
			oRenderer.renderProject( ProjectData );

		</cfscript>

	</cffunction>

	<cffunction name="fetchAddHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchEditHours" returntype="void" output="true">
		<cfargument name="FormData" required="false" default="#structNew( )#">

		<cfscript>


		</cfscript>

	</cffunction>

</cfcomponent>