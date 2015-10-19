// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-jquery-tokeninput
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.ui.all
//= require autocomplete-rails
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require addthis



$(document).ready(function() {
  $("#challenge_type_of_race").change(function() {
    if ($("#challenge_type_of_race").val() === 'MARATHON') {
    $('#totalMiles').val('26')
  } else if ($("#challenge_type_of_race").val() === 'HALF-MARATHON') {
    $('#totalMiles').val('13');
  } else if ($("#challenge_type_of_race").val() === '10K') {
    $('#totalMiles').val('6');
  } else if ($("#challenge_type_of_race").val() === '5K') {
    $('#totalMiles').val('3');
  } else if ($("#challenge_type_of_race").val() === 'IRONMAN') {
    $('#totalMiles').val('140');
  } else if ($("#challenge_type_of_race").val() === 'HALF-IRONMAN') {
    $('#totalMiles').val('70');
  } else if ($("#challenge_type_of_race").val() === 'OLYMPIC') {
    $('#totalMiles').val('26');
  } else if ($("#challenge_type_of_race").val() === 'SPRINT') {
    $('#totalMiles').val('13');
  } 
  });
});



function calculate() {
    var myTotalMiles = document.getElementById('totalMiles').value; 
    var myPricePerMile = document.getElementById('pricePerMile').value;
    var totalMoneyToRaise = document.getElementById('totalMoneyToRaise'); 
    var myResult = myTotalMiles * myPricePerMile;
    totalMoneyToRaise.value = myResult;
  
  }



function fn() {
  var myAmount = document.getElementById('amount').value;
  document.getElementById('donationAmount').value = myAmount;
}

 
