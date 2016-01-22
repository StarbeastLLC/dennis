// Make donations anonymous at /donations/:challenge_id
if ($('#crf-input-0').val() == "true"){
	console.log($('#nominize').val());
	$('#nominize').val("Anonymous");
	console.log($('#nominize').val());
}