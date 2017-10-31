<cfscript>
	if (!directoryExists(expandPath('./'))) {
		directoryCreate('./components');
	}
	arrayOfLocaFiles = arrayNew(1);
	arrayOfLocalFiles = directoryList( expandPath( "./components" ), false, "name" );
	writeDump( arrayOfLocalFiles );
</cfscript>