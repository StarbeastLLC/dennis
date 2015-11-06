defmodule Dennis.DashboardView do
  use Dennis.Web, :view

  def challenge_main_photo(challenge) do
  	if challenge.photo1 do
  		Dennis.ChallengePhoto.url({challenge.photo1, challenge})
  	else
  		"/images/c1.jpg"
  	end
  end

end