<cfcomponent output="true">


	<cffunction name="getHome" 		returntype="query" output="false">
		<cfargument name="UserId" 			type="string" 	required="false" default="">
		<cfargument name="ManagedUserList" 	type="string" 	required="false" default="">
		<cfargument name="ProjectNumber" 	type="string" 	required="false" default="">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
		 	SELECT 		p.ClientNumber, p.DisplayName as ProjectName, p.ProjectNumber,
		 				e.DateModified, e.EntryNumber, e.HoursWorked,
		 				e.Notes, e.UserNumber, e.Workdate,
		 				c.Name as ClientName, u.Supervisor, u.DisplayName as UserName
		 	FROM 		intEntries 		as e
		 	INNER JOIN 	intClients 		as c ON c.ClientNumber 		= e.ClientNumber
		 	INNER JOIN 	intUsers 		as u ON u.UserNumber 		= e.UserNumber
		 	INNER JOIN 	intProjects 	as p ON p.ProjectNumber 	= e.ProjectNumber
		 	<cfif UserId NEQ ''>
		 		WHERE e.UserNumber 		= 	<cfqueryparam value="#Trim(UserId)#"  				cfsqltype="cf_sql_integer">
		 		<cfif ProjectNumber NEQ ''>
		 			AND e.ProjectNumber = <cfqueryparam value="#Trim(ProjectNumber)#" 			cfsqltype="cf_sql_integer">
		 		</cfif>
		 		<cfif ManagedUserList NEQ ''>
		 			OR u.UserNumber 	IN  ( <cfqueryparam value="#Trim(ManagedUserList)#"  	cfsqltype="cf_sql_integer" list="yes"> )
		 			<cfif ProjectNumber NEQ ''>
		 				AND e.ProjectNumber = <cfqueryparam value="#Trim(ProjectNumber)#" 		cfsqltype="cf_sql_integer">
		 			</cfif>
		 		</cfif>

		 	</cfif>
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="getUsers" 	returntype="query" 	output="false">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		DisplayName, Supervisor, UserNumber
			FROM 		intUsers
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="getManagedUsers" returntype="query" output="false">
		<cfargument name="UserId"	type="string" 	required="true">
		<cfargument name="isAjax" 	type="boolean" 	required="false" default="0">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		UserNumber
			FROM 		intUsers
			WHERE 		Supervisor = <cfqueryparam value="#Trim(UserId)#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="getUser" 		returntype="query" 	output="false">
		<cfargument name="UserId"	type="string" 	required="true">
		<cfargument name="isAjax" 	type="boolean" 	required="false" default="0">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		DisplayName, Supervisor, UserNumber
			FROM 		intUsers
			WHERE 		UserNumber = <cfqueryparam value="#Trim(UserId)#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="getProjects" 	returntype="query" 	output="false">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		p.DisplayName, p.ClientNumber, p.ProjectNumber, c.ClientNumber
			FROM 		intProjects as p
			INNER JOIN 	intClients 	as c ON c.ClientNumber = p.ClientNumber
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="getProject" 	returntype="query" 	output="false">
		<cfargument name="ProjectId" 	type="string" 	required="true">
		<cfargument name="IsAjax" 		type="boolean" 	required="false" default="0">

		<cfset var Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		p.DisplayName, p.ClientNumber, p.ProjectNumber, c.Name as ClientName
			FROM 		intProjects as p
			INNER JOIN 	intClients 	as c ON c.ClientNumber = p.ClientNumber
			WHERE 		ProjectNumber = <cfqueryparam value="#Trim(ProjectId)#" cfsqltype="cf_sql_integer">
		</cfquery>

		<cfreturn Results>

	</cffunction>

	<cffunction name="addHours" 	returntype="boolean" output="false">
		<cfargument name="FormData" 		type="struct" required="true">
		<cfargument name="UserStruct" 		type="struct" required="true">
		<cfargument name="ProjectStruct" 	type="struct" required="true">

		<cfset Results = false>

		<cftransaction>

			<cftry>

				<cfquery datasource="ModoInt">
					INSERT INTO intEntries
					(
						ClientNumber,
						DateCreated,
						HoursWorked,
						Notes,
						ProjectNumber,
						UserNumber,
						WorkDate
					)
					VALUES(
						<cfqueryparam value="#Trim(ProjectStruct[ 'ClientNumber' ])#" 	cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#Now()#" 									cfsqltype="cf_sql_date">,
						<cfqueryparam value="#Trim(FormData[ 'HoursWorked' ])#" 		cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#Trim(FormData[ 'Notes' ])#" 				cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#Trim(ProjectStruct[ 'ProjectNumber' ])#" 	cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#Trim(UserStruct[ 'UserNumber' ])#" 		cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#Trim(FormData[ 'WorkDate' ])#"  			cfsqltype="cf_sql_date">
					)
				</cfquery>

				<cfset Results = true>

				<cftransaction action="commit">

				<cfcatch type="any">

					<cftransaction action="rollback">
					<cfdump var="#cfcatch#">

				</cfcatch>

			</cftry>

		</cftransaction>

		<cfreturn Results>

	</cffunction>

	<cffunction name="editHours" 	returntype="boolean" output="false">
		<cfargument name="FormData" 	type="struct" required="true">

		<cfset Results = false>

		<cftransaction>

			<cftry>

				<cfquery datasource="ModoInt">
					UPDATE intEntries
					SET
						DateModified 	= 	<cfqueryparam value="#Now()#" 								cfsqltype="cf_sql_date">,
						HoursWorked 	= 	<cfqueryparam value="#Trim(FormData[ 'HoursWorked' ])#" 	cfsqltype="cf_sql_integer">,
						Notes 			= 	<cfqueryparam value="#Trim(FormData[ 'Notes' ])#" 			cfsqltype="cf_sql_varchar">
					WHERE EntryNumber 	=  	<cfqueryparam value="#Trim(FormData[ 'EntryNumber' ])#" 	cfsqltype="cf_sql_integer">
				</cfquery>

				<cfset Results = true>

				<cftransaction action="commit">

				<cfcatch type="any">

					<cftransaction action="rollback">
					<cfdump var="#cfcatch#" abort="true">

				</cfcatch>

			</cftry>

		</cftransaction>

		<cfreturn Results>

	</cffunction>

</cfcomponent>