defmodule Dennis.ChallengeView do
  use Dennis.Web, :view

  alias Dennis.User
  alias Dennis.Donation

  def challenge_main_photo(challenge) do
    if challenge.photo1 do
      Dennis.ChallengePhoto.url({challenge.photo1, challenge})
    else
      "/images/c1.jpg"
    end
  end

  def donor(user_id) do
    user = User.find_by_id(user_id)

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
