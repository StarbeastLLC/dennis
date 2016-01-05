// Preview images before uploading them to S3
$(function () {
  function readURL(input) {
      if (input.files && input.files[0]) {
          var reader = new FileReader();
          
          reader.onload = function (e) {
              $('#preview-photo').attr('src', e.target.result);
          }
          
          reader.readAsDataURL(input.files[0]);
      }
  }

  $("#preview-photo-load").change(function(){
      readURL(this);
  });
  
});
  