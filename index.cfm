
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
				oIndex.fetchHome();
				break;

			case 'user':
				oIndex.fetchUsers();
				break;

			case 'processUser':
				oIndex.fetchProcessUser();
				break;

			case 'project':
				oIndex.fetchProjects();
				break;

			case 'processProject':
				oIndex.fetchProcessProject();
				break;

			case 'addhours':
				oIndex.fetchAddHours();
				break;

			case 'processAddHours':
				oIndex.fetchProcessAddHours();
				break;

			case 'edithours':
				oIndex.fetchEditHours();
				break;

			case 'processEditHours':
				oIndex.fetchProcessEditHours();
				break;

			default:
				oIndex.fetchHome();
				break;

		}

		oIndex.fetchFooter();

	} catch(any cfcatch){

		writeDump( cfcatch );

	}


</cfscript>