jQuery(function () {

	// detect if we are in the donation page
	var donate = $('button#donate');
	if (donate.length == 0) { return; }

	var pricePerMile = donate.data('mile-price');
	var dataKey = donate.data('key');
	var productName = donate.data('name');
	var productDesc = donate.data('description');
	var productImage = donate.data('image');
	var productAmount = pricePerMile;

	donate.removeAttr('data-mile-price')
		  .removeAttr('data-key')
		  .removeAttr('data-name')
		  .removeAttr('data-description')
		  .removeAttr('data-image');

	var milesBought = $('#donation_miles_bought');
	var totalToDonate = $('#total-to-donate');

	var handler = StripeCheckout.configure({
	    key: dataKey,
	    image: productImage,
	    locale: 'auto',
	    token: function(token) {
	      // Use the token to create the charge with a server-side script.
	      // You can access the token ID with `token.id`
	      handler.close();
		  $('#donation_transaction_token').val(token.id);
		  $('#donation_email').val(token.email);
	      donate.parent('form').submit();
	    }
	});

	donate.on('click', openCheckout);
	milesBought.on('blur keyup click', calculateTotal);

	function calculateTotal() {
		productAmount = (pricePerMile * milesBought.val());
		totalToDonate.val("$ " + productAmount);
	}
	calculateTotal();

	function openCheckout(e) {
		handler.open({
	      name: productName,
	      description: productDesc,
	      amount: productAmount * 100 // Stripe uses cents
	    });
	    e.preventDefault();
	}

	// Close Checkout on page navigation
	$(window).on('popstate', function() {
	    handler.close();
	});


});