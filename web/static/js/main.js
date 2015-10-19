$(document).ready(function() {
    $("select").crfs();
    $('.bxslider').bxSlider();
    $('[placeholder]').each(function() {  
        var input = $(this);
                    
        $(input).focus(function(){
            if (input.val() == input.attr('placeholder')) {
               input.val('').removeClass("placeholder");
            }
        });
            
        $(input).blur(function(){
           if (input.val() == '' || input.val() == input.attr('placeholder')) {
               input.val(input.attr('placeholder')).addClass("placeholder");
           }
        });
    }).blur();

    
    $('.fancy-sign-in').fancybox();
    
});

$(window).load(function() {
    var $scrollbar6 = $('.scroll1');
    $scrollbar6.tinyscrollbar({
        thumbSize: 21
    });
    var scrollbar6 = $scrollbar6.data("plugin_tinyscrollbar");
    $('.scroll1 .arrow-up').click(function() {
        if ($(".scroll1 .overview").position().top < 0) {
            scrollbar6.update(0);
        } else {
            scrollbar6.update(-$(".scroll1 .overview").position().top-40);
        };
        return false;
    });
    $('.scroll1 .arrow-down').click(function() {
        if ($(".inside .scroll1").height()+$(".scroll1 .overview").position().top < 5 ) {
            scrollbar6.update("bottom");
        } else {
            scrollbar6.update(-$(".scroll1 .overview").position().top+40);
        };
        return false;
    });

    var $scrollbar7 = $('.scroll2');
    $scrollbar7.tinyscrollbar({
        thumbSize: 21
    });
    var scrollbar7 = $scrollbar7.data("plugin_tinyscrollbar");
    $('.scroll2 .arrow-up').click(function() {
        if ($(".scroll2 .overview").position().top < 0) {
            scrollbar7.update(0);
        } else {
            scrollbar7.update(-$(".scroll2 .overview").position().top-40);
        };
        return false;
    });
    $('.scroll2 .arrow-down').click(function() {
        if ($(".inside .scroll2").height()+$(".scroll2 .overview").position().top < 5 ) {
            scrollbar7.update("bottom");
        } else {
            scrollbar7.update(-$(".scroll2 .overview").position().top+40);
        };
        return false;
    });

});

