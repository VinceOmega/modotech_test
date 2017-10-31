<cfcomponent output="true">

	<cffunction name="renderHeader" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">
		<cfargument name="CurrentUser" 	type="struct"	required="false" 	default="#structNew( )#">

		<cfoutput>
			<!DOCTYPE html>
			<html>
				<head>
					<title> Interview Application Test </title>
					<!--- <link rel="stylesheet" type="text/css" href="/bootstrap/css/3.3.7.bootstrap.css"> --->
					<!--- <link rel="stylesheet" type="text/css" href="/bootstrap/css/1.12.1.jquery-ui.min.css"> --->
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/vader/jquery-ui.min.css">
				</head>
				<body>
					<div class="--header -userInfo">
						<span class="--header -userName">
							<cfif CurrentUser[ 'DisplayName' ] NEQ ''>
								Welcome #CurrentUser[ 'DisplayName' ]#, here are your latest time logs
							<cfelse>
								Welcome, here are the latest time logs
							</cfif>
						</span>
					</div>
		</cfoutput>

	</cffunction>

	<cffunction name="renderFooter" returntype="void" output="true">
		<cfargument name="FormData" 			type="struct"	required="false" 	default="#structNew( )#">

		<cfoutput>
				<div class="--footer -container">
					<span class="--footer -copyright">

					</span>
				</div>
			</body>
			<!--- <script src="/bootstrap/js/3.2.1.jquery.min.js"/> --->
			<!--- <script src="/bootstrap/js/1.12.1.jquery-ui.min.js"/> --->

			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"/>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"/>
		</cfoutput>

	</cffunction>

	<cffunction name="renderHome" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">
		<cfargument name="HomeData" 	type="query"	required="false" 	default="#queryNew( '' )#">

		<cfset var index = queryNew('')>

		<cfoutput>
			<div class="--Home -dashboard">
				<table>
					<tbody>
						<tr>
							<th>Client Name</th>
							<th>Project Name</th>
							<th>Hours Worked</th>
							<th>Work Date</th>
							<th>User</th>
							<th>Actions</th>
						</tr>
						<cfloop query="HomeData">
							<tr>
								<td>#ClientName#</td>
								<td>#ProjectName#</td>
								<td>#HoursWorked#</td>
								<td>#dateFormat(WorkDate, 'mm-dd-yyyy')#</td>
								<td>#UserName#</td>
								<td><a href="?a=editHours&entryNumber=#EntryNumber#&UserId=#UserNumber#" class="-editHours" title="Edit Hours">[Edit Hours]</a></td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
			<div class="--Home -selection">
				<a href="?a=user">Select User</a>
				<a href="?a=project">Select Project</a>
				<cfif structKeyExists( SESSION, 'CurrentUser' ) AND structKeyExists( SESSION, 'CurrentProject' ) AND SESSION[ 'CurrentUser' ][ 'DisplayName' ] NEQ '' AND SESSION[ 'CurrentProject' ][ 'DisplayName' ] NEQ ''>
					<a href="?a=addhours">Add Hours</a>
				</cfif>
			</div>
		</cfoutput>

	</cffunction>

	<cffunction name="renderUsers" returntype="void" output="true">
		<cfargument name="UserQuery" type="query" required="true">

		<cfoutput>

			<form action="?a=processUser" method="post" class="--Users -selection">
					<label>User Name</label>
					<select name="UserId">
						<cfloop query="UserQuery">
							<option value="#UserNumber#">#DisplayName#</option>
						</cfloop>
					</select>
				<input type="submit" name="select" class="btn -blue">
			</form>

		</cfoutput>

	</cffunction>

	<cffunction name="renderProjects" returntype="void" output="true">
		<cfargument name="ProjectQuery" type="query" required="true">

		<cfoutput>

			<form action="?a=processProject" method="post" class="--Projects -selection">
				<label>Project Name</label>
				<select name="Project">
					<cfloop query="ProjectQuery">
						<option value="#ProjectNumber#">#DisplayName#</option>
					</cfloop>
				</select>
				<input type="submit" name="select" class="btn -blue">
			</form>

		</cfoutput>

	</cffunction>

	<cffunction name="renderAddHours" returntype="void" output="true">
		<cfargument name="FormData" type="struct" required="true">

		<cfoutput>

			<form action="?a=processAddHours" method="post" class="--Projects -selection">
				<label>Project - #SESSION[ 'CurrentProject' ][ 'DisplayName' ]#</label>
				<input type="text" name="HoursWorked">
				<input type="text" name="WorkDate" class="--Projects -workdate">
				<textarea name="Notes"></textarea>
				<input type="hidden" name="UserId" value="#SESSION[ 'CurrentUser' ][ 'UserNumber' ]#">
				<input type="submit" name="select" class="btn -blue">
			</form>

		</cfoutput>

	</cffunction>

	<cffunction name="renderEditHours" returntype="void" output="true">
		<cfargument name="FormData" type="struct" required="true">

		<cfoutput>

			<form action="?a=processEditHours" method="post" class="--Projects -selection">
				<label>Project - #SESSION[ 'CurrentProject' ][ 'DisplayName' ]#</label>
				<input type="text" name="HoursWorked">
				<textarea name="Notes"></textarea>
				<input type="hidden" name="UserId" value="#FormData[ 'UserId' ]#">
				<input type="hidden" name="EntryNumber" value="#FormData[ 'EntryNumber' ]#">
				<input type="submit" name="select" class="btn -blue">
			</form>

		</cfoutput>


	</cffunction>


</cfcomponent>