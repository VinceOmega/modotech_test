
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


		switch(Action){

			case 'home':
				if(StructKeyExists( FormData, 'reset' ) AND FormData[ 'reset' ] ){
					oSession.invalidateSession();
					location( '?a=home', false);
				}
				oIndex.fetchHeader();
				oIndex.fetchHome( FormData );
				oIndex.fetchFooter();
				break;

			case 'user':
				oIndex.fetchHeader();
				oIndex.fetchUsers( FormData );
				oIndex.fetchFooter();
				break;

			case 'processUser':
				oIndex.fetchHeader();
				oIndex.fetchProcessUser( FormData );
				oIndex.fetchFooter();
				break;

			case 'project':
				oIndex.fetchHeader();
				oIndex.fetchProjects( FormData );
				oIndex.fetchFooter();
				break;

			case 'processProject':
				oIndex.fetchHeader();
				oIndex.fetchProcessProject( FormData );
				oIndex.fetchFooter();
				break;

			case 'addhours':
				if( SESSION['CurrentUser']['DisplayName'] EQ '' ){
					location( '?a=home&success=0', false );
				}
				oIndex.fetchHeader();
				oIndex.fetchAddHours( FormData );
				oIndex.fetchFooter();
				break;

			case 'processAddHours':
				oSession.storeLastWorkDateUsed( FormData );
				oIndex.fetchHeader();
				oIndex.fetchProcessAddHours( FormData );
				oIndex.fetchFooter();
				break;

			case 'edithours':
				if( SESSION['CurrentUser']['DisplayName'] EQ ''){
					location( '?a=home&success=0', false );
				}

				oIndex.fetchHeader();
				oIndex.fetchEditHours( FormData );
				oIndex.fetchFooter();
				break;

			case 'processEditHours':
				oIndex.fetchHeader();
				oIndex.fetchProcessEditHours( FormData );
				oIndex.fetchFooter();
				break;

			case 'ajax':

				if( URL['ajax'] EQ 'getEntries' ){
					oIndex.fetchUserEntriesByWorkDate( FormData );
				}

				break;

			default:
				oIndex.fetchHeader();
				oIndex.fetchHome( FormData );
				oIndex.fetchFooter();
				break;

		}


	} catch(any cfcatch){

		writeDump( cfcatch );

	}

</cfscript>