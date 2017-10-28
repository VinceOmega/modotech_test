<cfcomponent output="true">

	<cfset oData 		= createObject( 'component', 'indexData' )>
	<cfset oRenderer  	= createObject( 'component', 'indexController' )>
	<cfset oSession 	= createObject( 'component', 'sessionController' )>

	<cffunction name="fetchHeader" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>



		</cfscript>

	</cffunction>

	<cffunction name="fetchFooter" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchHome" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>

			var CurrentUser = structNew( );
			var HomeData 	= queryNew( '' );
			CurrentUser 	= oSession.fetchCurrentUser( );
			HomeData 		= oData.getHome();
			oRenderer.renderHome( FormData, HomeData);

		</cfscript>

	</cffunction>

	<cffunction name="fetchUser" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchProject" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchAddHours" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchEditHours" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

	<cffunction name="fetchReviewHours" returntype="void" output="true">
		<cfargument name="FormData" required="false">

		<cfscript>


		</cfscript>

	</cffunction>

</cfcomponent>