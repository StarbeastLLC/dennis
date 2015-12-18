defmodule Dennis.ChallengeView do
  use Dennis.Web, :view

  alias Dennis.User
  alias Dennis.Donation

  def race_date_as_iso(date) do
    Ecto.Date.to_iso8601(date)
  end

  def parse_video_url(watch_url) do
    [video_id] = String.split watch_url, "https://www.youtube.com/watch?v=", trim: true
    "https://youtube.com/embed/" <> video_id
  end

  def challenge_main_photo(challenge) do
    if challenge.photo1 do
      Dennis.ChallengePhoto.url({challenge.photo1, challenge})
    else
      "/images/c1.jpg"
    end
  end

  def challenge_support_photos(challenge) do
    challenge
    |> Map.take([:photo2, :photo3, :photo4])
    |> Map.values
    |> Enum.filter(fn p -> p end)
    |> Enum.map(fn p -> Dennis.ChallengePhoto.url({p, challenge}) end)
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
