$(window).ready(function(){



		jQuery('.-workdate').datepicker();

		$('#hours-check-btn').mouseup(function(){
			var form = $('#hours-form');
			console.log(form);
			$.ajax({
				url: 	'?a=ajax&ajax=getEntries',
				data:  	{
					FormData: form
				},
				method: "POST"
			})
				.done(function(html){
					$('#hours-display').empty().append(html);
				})
				.fail(function(){
					console.log('something went wrong!?');
				});
				
			});

});