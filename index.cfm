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

	FormData = FORM;
	oIndex = createObject( 'component', "indexController" );

	oIndex.fetchHeader();

	switch(Action){

		case 'home':
			oIndex.fetchHome();
			break;

		case 'user':
			oIndex.fetchUser();
			break;

		case 'project':
			oIndex.fetchProject();
			break;

		case 'addhours':
			oIndex.fetchAddHours();
			break;

		case 'edithours':
			oIndex.fetchEditHours();
			break;

		case 'reviewhours':
			oIndex.fetchReviewHours();
			break;

		default
			oIndex.fetchHome();
			break;

	}

	oIndex.fetchFooter();

</cfscript>