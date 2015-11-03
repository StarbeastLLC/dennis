defmodule Dennis.ChallengeView do
  use Dennis.Web, :view

  alias Dennis.User
  alias Dennis.Donation

  def donor(user_id) do
    user = User.donor_identity(user_id)

    cond do
    	user.user_type == "org" ->
    		user.org_name
    	user.first_name == nil ->
    		user.email
    	:else ->
    		"#{user.first_name} #{user.last_name}"
    end	
  end

  def amount_to_raise(miles, mile_price) do
  	amount = miles * mile_price
  end

  def amount_donated(challenge_id) do
  	amount = Donation.amount_donated_to_challenge(challenge_id)
  end

end
