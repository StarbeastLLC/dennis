// Hide flash messages after some seconds
$(function () {
  $('document').ready(function() {
    setTimeout(function() {
    $(".alert").animate({opacity:'0'}, 3000);
    $('.alert').slideUp();
    }, 3800);
  });
})