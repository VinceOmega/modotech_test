<cfcomponent output="true">

	<cffunction name="renderHeader" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">
		<cfargument name="CurrentUser" 	type="struct"	required="false" 	default="#structNew( )#">

		<cfoutput>
			<!DOCTYPE html>
			<html lang="en">
				<head>
					<title> Interview Application Test </title>
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<!--- <link rel="stylesheet" type="text/css" href="/bootstrap/css/3.3.7.bootstrap.css"> --->
					<!--- <link rel="stylesheet" type="text/css" href="/bootstrap/css/1.12.1.jquery-ui.min.css"> --->
					<link href="https://fonts.googleapis.com/css?family=Exo+2" rel="stylesheet">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/themes/vader/jquery-ui.min.css">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
					<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/datepicker/0.6.3/datepicker.min.css">
					<link rel="stylesheet" type="text/css" href="style.css">
				</head>
				<body>
					<div id="content" class="container">
						<div class="--header -userInfo row">
							<div class="--header -logo col-lg-4 col-md-4 col-sm-12 col-xs-12">
								<a href="?a=home">
									<img src="/images/Logo.png">
								</a>
							</div>
							<div class="--header -userName col-lg-4 col-md-4 col-sm-12 col-xs-12">
								<cfif CurrentUser[ 'DisplayName' ] NEQ ''>
									Logged-in as #CurrentUser[ 'DisplayName' ]#
								<cfelse>
									Logged-in as Guest
								</cfif>
							</div>
							<cfif CurrentUser[ 'DisplayName' ] NEQ ''>
								<div class="--header -logout col-lg-4 col-md-4 col-sm-12 col-xs-12">
									<a href="?a=home&reset=1" title="logout"><i class="fa fa-sign-out"></i>Logout</a>
								</div>
							</cfif>
						</div>
		</cfoutput>

	</cffunction>

	<cffunction name="renderFooter" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">

		<cfoutput>
					<div class="--footer -container row">
						<div class="--footer -copyright col-lg-12 col-md-12 col-sm-12 col-xs-12">

						</div>
					</div>
				</div> <!--- End of id="content" div --->
			</body>
			<!--- <script src="/bootstrap/js/3.2.1.jquery.min.js"/> --->
			<!--- <script src="/bootstrap/js/1.12.1.jquery-ui.min.js"/> --->

			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/datepicker/0.6.3/datepicker.min.js"></script>
			<script src="script.js"></script>
		</cfoutput>

	</cffunction>

	<cffunction name="renderHome" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">
		<cfargument name="HomeData" 	type="query"	required="false" 	default="#queryNew( '' )#">

		<cfset var index = queryNew('')>

		<cfoutput>
			<div class="--Home -dashboard row">
				<table class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<tbody>
						<tr class="-table-header">
							<th class="hidden-sm hidden-xs">Client Name</th>
							<th>Project Name</th>
							<th>Hours Worked</th>
							<th>Work Date</th>
							<th>User</th>
							<th>Actions</th>
						</tr>
						<cfloop query="HomeData">
							<tr>
								<td class="hidden-sm hidden-xs">#ClientName#</td>
								<td>#ProjectName#</td>
								<td>#HoursWorked#</td>
								<td>#dateFormat(WorkDate, 'mm-dd-yyyy')#</td>
								<td>#UserName#</td>
								<cfif structKeyExists( SESSION, 'CurrentUser' ) AND SESSION[ 'CurrentUser' ][ 'DisplayName' ] NEQ ''>
									<td><a href="?a=editHours&entryNumber=#EntryNumber#&UserId=#UserNumber#" class="-editHours" title="Edit #UserName#'s Hours"><i class="fa fa-pencil" aria-hidden="true"/></a></td>
								<cfelse>
									<td><i class="fa fa-ban" aria-hidden="true"></i></td>
								</cfif>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
			<div class="--Home -selection">
				<a href="?a=user" class="btn btn-primary">Select User</a>
				<a href="?a=project" class="btn btn-primary">Select Project</a>
				<cfif structKeyExists( SESSION, 'CurrentUser' ) AND structKeyExists( SESSION, 'CurrentProject' ) AND SESSION[ 'CurrentUser' ][ 'DisplayName' ] NEQ '' AND SESSION[ 'CurrentProject' ][ 'DisplayName' ] NEQ ''>
					<a href="?a=addhours" class="btn btn-primary">Add Hours</a>
				</cfif>
			</div>
		</cfoutput>

	</cffunction>

	<cffunction name="renderUsers" returntype="void" output="true">
		<cfargument name="UserQuery" type="query" required="true">

		<cfoutput>

			<div class="--Users -hours col-lg-6 col-md-6 col-sm-12 col-xs-12" id="hours-display">

			</div>

			<div class="--Users -selection col-lg-6 col-md-6 col-sm-12 col-xs-12">
				<form action="?a=processUser" method="post" class="--Users -selection" id="hours-form">
						<label>User Name</label>
						<select name="UserId">
							<cfloop query="UserQuery">
								<option value="#UserNumber#">#DisplayName#</option>
							</cfloop>
						</select><br>
					<div class="-submission">
						<input type="submit" name="select" class="btn btn-primary btn-lg -long">
					</div>
				</form>
			</div>

		</cfoutput>

	</cffunction>

	<cffunction name="renderProjects" returntype="void" output="true">
		<cfargument name="ProjectQuery" type="query" required="true">

		<cfoutput>

			<div class="--Projects -hours col-lg-6 col-md-6 col-sm-12 col-xs-12" id="hours-display">

			</div>

			<div class="--Projects -selection">
				<form action="?a=processProject" method="post" class="--Projects -selection" id="hours-form">
					<label>Project Name</label>
					<select name="Project">
						<cfloop query="ProjectQuery">
							<option value="#ProjectNumber#">#DisplayName#</option>
						</cfloop>
					</select><br>
					<div class="-submission">
						<input type="submit" name="select" class="btn btn-primary btn-lg -long">
					</div>
				</form>
			</div>

		</cfoutput>

	</cffunction>

	<cffunction name="renderAddHours" returntype="void" output="true">
		<cfargument name="FormData" type="struct" required="true">

		<cfoutput>

			<div class="--AddHours -selection">
				<form action="?a=processAddHours" method="post" class="--Projects -selection">
					<input type="hidden" name="UserId" value="#SESSION[ 'CurrentUser' ][ 'UserNumber' ]#">
					<h3>Project - #SESSION[ 'CurrentProject' ][ 'DisplayName' ]#</h3>
					<label for="HoursWorked">Hours Worked</label><input type="text" name="HoursWorked"><br>
					<label for="WorkDate">Work Date</label><input type="text" name="WorkDate" class="--Projects -workdate" value="#FormData[ 'WorkDate' ]#"><br>
					<label for="Notes">Notes</label><textarea name="Notes"></textarea><br>
					<div class="-submission">
						<input type="submit" name="select" class="btn btn-primary btn-lg -long">
					</div>
				</form>
			</div>

		</cfoutput>

	</cffunction>

	<cffunction name="renderEditHours" returntype="void" output="true">
		<cfargument name="FormData" type="struct" required="true">

		<cfoutput>

			<div class="--EditHours -selection">
				<form action="?a=processEditHours" method="post" class="--Projects -selection">
					<input type="hidden" name="UserId" value="#FormData[ 'UserId' ]#">
					<input type="hidden" name="EntryNumber" value="#FormData[ 'EntryNumber' ]#">
					<h3>Project - #SESSION[ 'CurrentProject' ][ 'DisplayName' ]#</h3><br>
					<label for="HoursWorked">Hours Worked</label><input type="text" name="HoursWorked" class="--Projects -workdate" value="#FormData[ 'WorkDate' ]#"><br>
					<label for="Notes">Notes</label><textarea name="Notes"></textarea><br>
					<div class="-submission">
						<input type="submit" name="select" class="btn btn-primary btn-lg -long">
					</div>
				</form>
			</div>

		</cfoutput>

	</cffunction>

	<cffunction name="renderUserEntriesByWorkDate" returntype="void" output="true">
		<cfargument name="UserEntries" type="struct" required="true">

		<cfoutput>
				<table class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<tbody>
						<tr class="-table-header">
							<th class="hidden-sm hidden-xs">Client Name</th>
							<th>Project Name</th>
							<th>Hours Worked</th>
							<th>Work Date</th>
							<th>User</th>
						</tr>
						<cfloop query="UserEntries">
							<tr>
								<td class="hidden-sm hidden-xs">#ClientName#</td>
								<td>#ProjectName#</td>
								<td>#HoursWorked#</td>
								<td>#dateFormat(WorkDate, 'mm-dd-yyyy')#</td>
								<td>#UserName#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
		</cfoutput>

	</cffunction>


</cfcomponent>