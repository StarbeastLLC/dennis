// Alert if photos are over 10MB
$(function () {
	var imageInput = $('#preview-photo-load');
	var multipleImageInput = $('#multiple-photo-load');
	//10MB, binded to web/uploaders' Imagemagick config
	var maxImageSize = 10000000;

    imageInput.bind('change', function() {
	   if (getImageSize() > maxImageSize) {
	   	  imageInput.val('');
	      alert("Your image must be under 10MB");
	   } else {
	   	  console.log("Your image is under 10MB and everything is awesome");
	   };
    });

    multipleImageInput.bind('change', function() {
      var multipleImageSize = getMultipleImageSize();
      for (var singleImage of multipleImageSize) {
	    if (singleImage > maxImageSize) {
	      multipleImageInput.val('');
	      alert("All your images must be under 10MB");
	      break;
	    } else {
	      console.log(singleImage);
	    };
	  };
    });

	function getImageSize(){
		return imageInput[0].files[0].size;
	};

	function getMultipleImageSize(){
		var multipleImageSize = [];
		for (var acc = 0; acc < multipleImageInput[0].files.length; acc++) {
          multipleImageSize.push(multipleImageInput[0].files[acc].size);
		};
		return multipleImageSize;
	};
});