// Prevent athlete to create challenges before the current day

$(function () {
    var date = new Date().toJSON().slice(0, 10)
    $('#today').attr('min', date)
});