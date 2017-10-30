<cfcomponent output="true">

	<cffunction name="renderHeader" returntype="void" output="true">
		<cfargument name="FormData" 	type="struct"	required="false" 	default="#structNew( )#">
		<cfargument name="CurrentUser" 	type="stuct"	required="false" 	default="#structNew( )#">

		<cfoutput>
			<!DOCTYPE html>
			<html>
				<head>
					<title> Interview Application Test </title>
					<link rel="stylesheet" type="text/css" href="/bootstrap/css/3.3.7.bootstrap.css">
					<link rel="stylesheet" type="text/css" href="/bootstrap/css/1.12.1.jquery-ui.min.css">
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
			<script src="/bootstrap/js/3.2.1.jquery.min.js"/>
			<script src="/bootstrap/js/1.12.1.jquery-ui.min.js"/>
		</cfoutput>	

	</cffunction>

</cfcomponent>