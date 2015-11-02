jQuery(function () {

	console.log("DONATION.js")

	// detect if we are in the donation page
	var donate = $('button#donate');
	if (donate.length == 0) { return; }

	console.log("DONATION.js PAGE");

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
	var tip = $('#donation_tip');
	var totalToDonate = $('#total_to_donate');

	var handler = StripeCheckout.configure({
	    key: dataKey,
	    image: productImage,
	    locale: 'auto',
	    token: function(token) {
	      // Use the token to create the charge with a server-side script.
	      // You can access the token ID with `token.id`
	      handler.close();
	      console.log("TOOOOK ", token);
		  $('#donation_transaction_token').val(token.id);
		  $('#donation_email').val(token.email);
	      donate.parent('form').submit();
	    }
	});

	donate.on('click', openCheckout);
	milesBought.on('blur keyup', calculateTotal);
	tip.on('blur keyup', calculateTotal);

	function calculateTotal() {
		productAmount = (pricePerMile * milesBought.val()) + 
					(tip.val() * 1);
		totalToDonate.text(productAmount);
	}
	calculateTotal();

	function openCheckout(e) {
		handler.open({
	      name: productName,
	      description: productDesc,
	      amount: productAmount * 100 // stripe uses cents
	    });
	    e.preventDefault();
	}

	// Close Checkout on page navigation
	$(window).on('popstate', function() {
	    handler.close();
	});

});