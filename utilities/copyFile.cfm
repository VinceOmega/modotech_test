<cfset sourcePath 			= "#expandPath('./')#" & "uploadfile.cfm"> 
<cfset destinationPath 		= "#expandPath('./components')#">
<cffile action="copy" source="#sourcePath#" destination="#destinationPath#">