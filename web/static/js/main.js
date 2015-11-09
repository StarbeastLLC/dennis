$(document).ready(function() {
    $("select").crfs();
    $(".create-content .checkbox input, .reddem-modal .checkbox input").crfi();
    $('.bxslider').bxSlider();

    $(".file-set input[type=file]").change(function() {
        if (!$(this).val()=="") {
            $(this).parent().find(".url").addClass("active").text($(this).val().replace(/C:\\fakepath\\/i, ''));
        } else {
            $(this).parent().find(".url").removeClass("active").text($(this).attr("title"));
        }
    });

/* 
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
*/

    if (/*@cc_on !@*/false && (
           document.documentMode === 9)
       ) {
        // IE 9 or 10 (not 8 or 11!)
        document.documentElement.className += ' ie9';
    }
    
    $('.fancybox-open').fancybox({
        afterLoad : function() {
            $(".fancybox-skin").addClass("style2")
        },
    });
    
    $('.fancy-sign-in').fancybox();
    
    $(".fancybox2").fancybox({
        openEffect  : 'none',
        closeEffect : 'none',
        helpers : {
            title : {
                type : 'over'
            }
        }
    });
});

$(window).load(function() {
    $(".reddem-modal").addClass("as")
    $('.slider-v .slides').bxSlider({
        mode: 'vertical',
        slideMargin: 0,
        auto: true,
        pause: 4000,
        controls: false,
        pager: false
    });

    var $scrollbar6 = $('.scroll1');
    if ($(".dash-list").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 640
        });
    } else if ($(".cols-2-haf.full").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 1075
        });
    } else if ($(".pro-details").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 160
        });
    } else {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21
        });
    };
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

    window.setTimeout(function() {
        $(".welcome .video").addClass("loaded")
    }, 1000);

});

