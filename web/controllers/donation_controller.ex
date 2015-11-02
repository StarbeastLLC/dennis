defmodule Dennis.DonationController do
	use Dennis.Web, :controller

	alias Dennis.Challenge 
	alias Dennis.Donation

	def new(conn, %{ "challenge_id" => challenge_id } = _params) do
		challenge = Challenge.get_challenge(challenge_id)
		donation = Donation.changeset(%Donation{miles_bought: 1, tip: 0, total_donated: challenge.mile_price})	
		conn
		|> render("new.html", challenge: challenge, donation: donation)
	end

	def create(conn, %{"challenge_id" => challenge_id, "donation" => (%{"email" => email} = donation_params)}) do
		challenge = Challenge.get_challenge(challenge_id)
		case Donation.charge_donation(challenge, donation_params, email) do
			{:ok, donation} -> 
				conn
				|> put_flash(:info, "Thanks for your donation!")
				|> redirect(to: challenge_path(conn, :show, challenge_id))
			{:error, message} ->
				conn
				|> put_flash(:error, "The donation was unsuccessful. #{message}")
				|> render("new.html", challenge: challenge)
		end
	end
end