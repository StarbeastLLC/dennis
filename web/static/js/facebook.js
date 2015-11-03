$(function () {

	window.fbAsyncInit = function() {
		FB.init({
		  appId      : $('meta[name="fb-app-id"]').attr('content'),
		  xfbml      : true,
		  status     : true,
		  cookie     : true,
		  version    : 'v2.4'
		});
	};

	var csrf_token = $('meta[name="fb-csrf-token"]').attr('content');

	// obtains fb current user and creates a session
	// at our app.
	function fbAuth(statusResponse) {
		FB.api('/me', {fields: 'email,first_name,last_name'}, function (response) {
		  console.log('fb-me', response);

		  $('#fb_auth #user_fb_id').val(response.id);
		  $('#fb_auth #user_fb_token').val(statusResponse.authResponse.accessToken);
		  $('#fb_auth #user_email').val(response.email);
		  $('#fb_auth #user_first_name').val(response.first_name);
		  $('#fb_auth #user_last_name').val(response.last_name);
		  $('#fb_auth').submit();

		})
	}

	function fbLogin() {
	  FB.getLoginStatus(function (statusResponse) {
	  	if (statusResponse.status === 'connected') {
	  		fbAuth(statusResponse);
	  	} else {
	  		FB.login(function (loginResponse) {
	  			if (loginResponse.authResponse) {
	  				fbLogin();
	  			}
	  		}, {scope: 'email'});
	  	}
	  });
	}

	$(document).on('click', '.fb-login', fbLogin);

});


(function(d, s, id){
 var js, fjs = d.getElementsByTagName(s)[0];
 if (d.getElementById(id)) {return;}
 js = d.createElement(s); js.id = id;
 js.src = "//connect.facebook.net/en_US/sdk.js";
 fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));