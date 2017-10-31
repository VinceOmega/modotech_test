
		<cfset Results = queryNew( '' )>

		<cfquery datasource="ModoInt" name="Results">
		 	SELECT 		p.ClientNumber, p.DisplayName as ProjectName, p.ProjectNumber,
		 				e.DateModified, e.EntryNumber, e.HoursWorked,
		 				e.Notes as ClientName, e.UserNumber, e.Workdate,
		 				c.Name, u.Supervisor, u.DisplayName as UserName


		 	FROM 		intEntries 		as e
		 	INNER JOIN 	intClients 		as c ON c.ClientNumber 		= e.ClientNumber
		 	INNER JOIN 	intUsers 		as u ON u.UserNumber 		= e.UserNumber
		 	INNER JOIN 	intProjects 	as p ON p.ProjectNumber 	= e.ProjectNumber

		</cfquery>

		<cfdump var="#Results#">