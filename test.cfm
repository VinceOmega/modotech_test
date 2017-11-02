
		<cfset Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
			SELECT 		p.ClientNumber, p.DisplayName as ProjectName, p.ProjectNumber,
		 				e.DateModified, e.EntryNumber, e.HoursWorked,
		 				e.Notes, e.UserNumber, e.Workdate,
		 				c.Name as ClientName, u.Supervisor, u.DisplayName as UserName
		 	FROM 		intEntries 		as e
		 	INNER JOIN 	intClients 		as c ON c.ClientNumber 		= e.ClientNumber
		 	INNER JOIN 	intUsers 		as u ON u.UserNumber 		= e.UserNumber
		 	INNER JOIN 	intProjects 	as p ON p.ProjectNumber 	= e.ProjectNumber
		 	WHERE 	e.UserNumber 		= 		<cfqueryparam 	value="#Trim(1)#"  	cfsqltype="cf_sql_integer">
		 	AND 	e.WorkDate 			= 	<cfqueryparam 	value="#Trim('10/18/2017')#" 	cfsqltype="cf_sql_datetime">
		</cfquery>

		<cfdump var="#Results#">