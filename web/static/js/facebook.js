window.fbAsyncInit = function() {
	FB.init({
	  appId      : '974600335935982',
	  xfbml      : true,
	  status     : true,
	  cookie     : true,
	  version    : 'v2.4'
	});
};

$(document).on('ready', function () {

	// obtains fb current user and creates a session
	// at our app.
	function fbAuth(statusResponse) {
		FB.api('/me', {fields: 'email,first_name,last_name'}, function (response) {
		  console.log('fb-me', response);
		  $.post('/facebook', {
		  	fb_id: response.id,
		  	fb_token: statusResponse.authResponse.accessToken,
		  	email: response.email,
		  	first_name: response.first_name,
		  	last_name: response.last_name
		  });
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