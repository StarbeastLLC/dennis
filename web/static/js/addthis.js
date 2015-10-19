// turbolinks addthis

addthisInit = function() {

  // Remove all global properties set by addthis, otherwise it won't reinitialize
  if(window.addthis) {
       window.addthis = null;
        window._adr = null;
        window._atc = null;
        window._atd = null;
        window._ate = null;
        window._atr = null;
        window._atw = null;
    window.addthis_share = null;
  }


  // Finally, load addthis
  $.getScript("http://s7.addthis.com/js/300/addthis_widget.js#pubid=ra-54760eaa6926ee24");

    // addthis.init();

  // });
}

$(document).ready(addthisInit);





  //  $.getScript("//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-54760eaa6926ee24");
//  });

