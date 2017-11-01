
<cfscript>

	param URL.a='home';

	Action 		= '';
	FormData 	= structNew();
	Action 		= URL[ 'a' ];
	i 			= 0;

	//put all the url vars in the form scope
	for( index in URL){
		FORM[ index ] = URL[ index ];
	}

	oIndex 		= createObject( 'component', 'interview.Larry.indexController' );
	oSession 	= createObject( 'component', 'interview.Larry.sessionController' );
	FormData 	= FORM;

	try{

		oIndex.fetchHeader();

		switch(Action){

			case 'home':
				if(StructKeyExists( FormData, 'reset' ) AND FormData[ 'reset' ] ){
					oSession.invalidateSession();
					location( '?a=home', false);
				}

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
				if( SESSION['CurrentUser']['DisplayName'] EQ '' ){
					location( '?a=home&success=0', false );
				}

				oIndex.fetchAddHours( FormData );
				break;

			case 'processAddHours':
				oIndex.fetchProcessAddHours( FormData );
				break;

			case 'edithours':
				if( SESSION['CurrentUser']['DisplayName'] EQ '' ){
					location( '?a=home&success=0', false );
				}

				oIndex.fetchEditHours( FormData );
				break;

			case 'processEditHours':
				oIndex.fetchProcessEditHours( FormData );
				break;

			case 'ajax':

				if( URL['ajax'] EQ 'getEntries' ){
					oIndex.fetchUserEntriesByWorkDate( FormData );
				}

				break;

			default:
				oIndex.fetchHome( FormData );
				break;

		}

		oIndex.fetchFooter();

	} catch(any cfcatch){

		writeDump( cfcatch );

	}

</cfscript>