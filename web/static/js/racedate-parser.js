// Parse date with Moment.js
$(function () {
  var raceDate = $('#iso-race-date').html();
  var raceDateParsed = moment(raceDate).format('MMMM Do YYYY');
  $('#iso-race-date').text(raceDateParsed);
});