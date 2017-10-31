
<cfscript>

	param URL.a='home';
	this.mappings['components'] = getDirectoryFromPath(getCurrentTemplatePath());

	Action 		= '';
	FormData 	= structNew();
	Action 		= URL[ 'a' ];
	i 			= 0;

	//put all the url vars in the form scope
	for( index in URL){
		FORM[ index ] = URL[ index ];
	}

	oIndex 		= createObject('component', 'interview.Larry.indexController');
	FormData 	= FORM;

	
	try{

		oIndex.fetchHeader();

		switch(Action){

			case 'home':
				oIndex.fetchHome( FormData );
				break;

			case 'user':
				oIndex.fetchUsers( FormData );
				break;

			case 'processUser':
				oIndex.fetchProcessUser( FormData );
				break;

			case 'project':
				oIndex.fetchProjects( FormData );
				break;

			case 'processProject':
				oIndex.fetchProcessProject( FormData );
				break;

			case 'addhours':
				oIndex.fetchAddHours( FormData );
				break;

			case 'processAddHours':
				oIndex.fetchProcessAddHours( FormData );
				break;

			case 'edithours':
				oIndex.fetchEditHours( FormData );
				break;

			case 'processEditHours':
				oIndex.fetchProcessEditHours( FormData );
				break;

			default:
				oIndex.fetchHome( FormData );
				break;

		}

		oIndex.fetchFooter();

	} catch(any cfcatch){

		writeDump( cfcatch );

	}

writeDump( var="#URL#", 		label="URL" );
writeDump( var="#FORM#", 		label="FORM" );
writeDump( var="#SESSION#", 	label="SESSION" );
writeDump( var="#ARGUMENTS#",  	label="ARGUMENT" );

</cfscript>