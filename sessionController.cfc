<cfcomponent output="true">

	<cffunction name="fetchCurrentUser" returntype="struct" output="true">
		
		<cfscript>
			
			var CurrentUser = structNew( );
			CurrentUser[ 'DisplayName' ] 		= '';
			CurrentUser[ 'Supervisor' ] 		= '';
			CurrentUser[ 'UserNumber' ] 		= '';
			CurrentUser[ 'UsersManaged' ] 		= '';

			if( !structKeyExists( SESSION, 'CurrentUser' ) ){
				
				SESSION[ 'CurrentUser' ] = queryNew( '' );
				SESSION[ 'CurrentUser' ] = CurrentUser;

			}

			return SESSION[ 'CurrentUser' ];

		</cfscript>
		
	</cffunction>

	<cffunction name="storeCurrentUser" returntype="struct" output="true">
		<cfargument name="UserQuery" 			type="query" 	required="yes">
		<cfargument name="ManagedUserList" 		type="string"  	required="no" default="">

		<cfscript>

			var row = queryNew( '' );

			if( !structKeyExists( SESSION, 'CurrentUser' ) ){

				SESSION[ 'CurrentUser' ] = structNew( );

			} 

			for( row in UserQuery ){

				SESSION[ 'CurrentUser' ][ 'DisplayName' ]	=  row.DisplayName;
				SESSION[ 'CurrentUser' ][ 'Supervisor' ] 	=  row.Supervisor;
				SESSION[ 'CurrentUser' ][ 'UserNumber' ] 	=  row.UserNumber;
				
			}

			SESSION[ 'CurrentUser' ][ 'UsersManaged' ] 	= ManagedUserList;

			return SESSION[ 'CurrentUser' ];

		</cfscript>
		
	</cffunction>

	<cffunction name="fetchProject" returntype="struct" output="true">

		<cfscript>
			
			var CurrentProject = structNew( );
			CurrentProject[ 'DisplayName' ] 		= '';
			CurrentProject[ 'ClientName' ] 			= '';
			CurrentProject[ 'ProjectNumber' ] 		= '';
			CurrentProject[ 'ClientNumber' ] 		= '';

			if( !structKeyExists( SESSION, 'CurrentProject' ) ){
				
				SESSION[ 'CurrentProject' ] = queryNew( '' );
				SESSION[ 'CurrentProject' ] = CurrentProject;

			}

			return SESSION[ 'CurrentProject' ];

		</cfscript>

	</cffunction>

	<cffunction name="storeProject" returntype="struct" output="true">
		<cfargument name="ProjectQuery" type="query" 	required="yes">

		<cfscript>

			var row = queryNew( '' );

			if( !structKeyExists( SESSION, 'CurrentProject' ) ){

				SESSION[ 'CurrentProject' ] = structNew( );

			} 

			for( row in ProjectQuery ){

				SESSION[ 'CurrentProject' ][ 'DisplayName' ] 	=  	row.DisplayName;
				SESSION[ 'CurrentProject' ][ 'ProjectNumber' ] 	=  	row.ProjectNumber;
				SESSION[ 'CurrentProject' ][ 'ClientName' ] 	=  	row.ClientName;
				SESSION[ 'CurrentProject' ][ 'ClientNumber' ] 	= 	row.ClientNumber;
				
			}

			return SESSION[ 'CurrentProject' ];

		</cfscript>

	</cffunction>

</cfcomponent>