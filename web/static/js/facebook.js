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

	$(document).on('click', '.fb-login', function (e) {

	  // obtains fb current user and creates a session
	  // at our app.
      function fbLogin() {
        FB.api('/me', {fields: 'email,first_name,last_name'}, function (response) {
          console.log('fb-me', response);
        })
      }

	  FB.getLoginStatus(function (response) {
	  	if (response.status === 'connected') {
			fbLogin();	  		
	  	} else {
	  		FB.login(function (response) {
	  			console.log('fb-login', response);
	  			if (response.authResponse) {
	  				fbLogin();
	  			}
	  		}, {scope: 'email'});
	  	}
	  })
	});

});


(function(d, s, id){
 var js, fjs = d.getElementsByTagName(s)[0];
 if (d.getElementById(id)) {return;}
 js = d.createElement(s); js.id = id;
 js.src = "//connect.facebook.net/en_US/sdk.js";
 fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));