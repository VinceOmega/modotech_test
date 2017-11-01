$(window).ready(function(){

		var form = $('#hours-form');

		jQuery('.-workdate').datepicker();

		$.ajax({
			url: 	'?a=ajax&ajax=getEntries',
			data:  	form,
			method: "POST",
			.done(function(html){
				$('#hours-display').empty().append(html);
			})
			.fail(function(){
				console.log('something went wrong!?');
			})
			
		});
});