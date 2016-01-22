function is_touch_device() {
  return 'ontouchstart' in window // works on most browsers 
      || 'onmsgesturechange' in window; // works on ie10
};

$(document).ready(function() {

    // Welcome to the argentinian void
    $('.minus, .plus').click(function(e){
        e.preventDefault();
        
        var type  = $(this).attr('class');
        var input = $(this).parent().find('input');
        var currentVal = parseInt(input.val());
        if (!isNaN(currentVal)) {
            if(type == 'minus') {
                
                if(currentVal > input.attr('min')) {
                    input.val(currentVal - 1).change();
                } 
                if(parseInt(input.val()) == input.attr('min')) {
                    $(this).attr('disabled', true);
                }
            } else if(type == 'plus') {
                if(currentVal < input.attr('max')) {
                    input.val(currentVal + 1).change();
                }
                if(parseInt(input.val()) == input.attr('max')) {
                    $(this).attr('disabled', true);
                }
            }
        } else {
            input.val(0);
        }
    });
    
    $('.input input').focusin(function(){
       $(this).data('oldValue', $(this).val());
    });
    $('.input input').change(function() {
        
        var minValue =  parseInt($(this).attr('min'));
        var maxValue =  parseInt($(this).attr('max'));
        var valueCurrent = parseInt($(this).val());
        
        name = $(this).attr('name');
        if(valueCurrent >= minValue) {
            $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
        } else {
            alert('Sorry, the minimum value was reached');
            $(this).val($(this).data('oldValue'));
        }
        if(valueCurrent <= maxValue) {
            $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
        } else {
            alert('Sorry, the maximum value was reached');
            $(this).val($(this).data('oldValue'));
        }

        $(".total input").val("$ "+valueCurrent*$(".default").val().replace("$ ", ""));
    });
    $('.input input').keydown(function (e) {
            // Allow: backspace, delete, tab, escape, enter and .
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
                 // Allow: Ctrl+A
                (e.keyCode == 65 && e.ctrlKey === true) || 
                 // Allow: home, end, left, right
                (e.keyCode >= 35 && e.keyCode <= 39)) {
                     // let it happen, don't do anything
                     return;
            }
            // Ensure that it is a number and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });
    $("select").crfs();
    $(".create-content .checkbox input, .reddem-modal .checkbox input, .form-donation input[type=checkbox]").crfi();
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
            },
            arrows: true
        }
    });

    $('.reddem-modal .checkbox input').change(function() {      
        if ($(this).is(":checked")) {       
            $(".open-modal input").prop("checked", true);       
            $(".open-modal label").addClass("checked");     
        } else {        
            $(".open-modal input").prop("checked", false);      
            $(".open-modal label").removeClass("checked");      
        };      
    });     
    $('.reddem-modal .submit').click(function() {       
        $(".fancybox-close").trigger("click")       
        return false;       
    });     
    $('.open-modal').click(function() {
        var fancyboxToOpen = $(this).attr("data-fancybox-to-open") || "fancybox-open";
        fancyboxToOpen = "." + fancyboxToOpen;
        $(fancyboxToOpen).trigger("click");
        return false;       
    });
});

$(window).load(function() {
    $(".reddem-modal").addClass("as")
    // Donations slides
    $('.slider-v .slides').bxSlider({
        mode: 'vertical',
        slideMargin: 0,
        auto: true,
        pause: 4000,
        controls: false,
        pager: false
    });

    $( "#datepicker" ).datepicker({
        dateFormat: "dd/mm/yy"
    });
    if (is_touch_device()) {
        $("body").addClass("touch-device")
    } else {

    var $scrollbar6 = $('.scroll1');
    if ($(".dash-list").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 640,
            wheelLock: false,
        });
    } else if ($(".cols-2-haf.full.height2").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 570,
            wheelLock: false,
        });
    } else if ($(".cols-2-haf.full").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 1075,
            wheelLock: false,
        });
    } else if ($(".pro-details").length) {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            trackSize: 160,
            wheelLock: false,
        });
    } else {
        $scrollbar6.tinyscrollbar({
            thumbSize: 21,
            wheelLock: false,
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
    $('.datapicker').click(function() {     
        $(".datapicker input").trigger("focus")
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
};
    
});

