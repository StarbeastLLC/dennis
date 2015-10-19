$(document).ready(function() {
	$("select").crfs();

	$('.masonry').masonry({
	  columnWidth: 1,
	  isFitWidth: true,
	  itemSelector: '.item'
	});
	
	$('.masonry-list').masonry({
	  columnWidth: 1,
	  isFitWidth: true,
	  itemSelector: '.item'
	});
	
	$('.start-chalange fieldset label').click(function() {  
		$(this).next().trigger("focus");
	});

	$('.run-head .collected ul').bxSlider({
		mode: 'vertical',
		slideMargin: 0,
		auto: true,
		pager: false,
		controls: false,
		minSlides: 4,
		maxSlides: 4
	});

	$('.gallery-slider').slick({
		dots: true,
		infinite: true,
		speed: 300,
		slidesToShow: 1
	});

	$('.start-chalange fieldset label + input').each(function() {  
		var label = $(this).prev();
		var input = $(this);
					
		$(input).focus(function(){
			if (input.val() == "") {
			   label.hide();
			}
		});
			
		$(input).blur(function(){
		   if (input.val() == '' || input.val() == input.attr('placeholder')) {
			   label.show();
		   }
		});
	}).blur();
});