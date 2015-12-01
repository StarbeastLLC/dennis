defmodule Dennis.DashboardView do
  use Dennis.Web, :view

  def global_accumulated(challenges) do
    
  end

  def challenge_main_photo(challenge) do
  	if challenge.photo1 do
  		Dennis.ChallengePhoto.url({challenge.photo1, challenge})
  	else
  		"/images/c1.jpg"
  	end
  end

  def cause_main_photo(cause) do
  	if cause.photo1 do
  		Dennis.CausePhoto.url({cause.photo1, cause})
  	else
  		"/images/c1.jpg"
  	end
  end

  def fb_avatar_url(user) do
    "http://avatars.io/facebook/#{user.fb_id}?size=large"
  end

  def is_fb_user(user) do
    user.fb_id != nil
  end

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def stripe_connect_url do
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_70DpQpxpPLuYLFAGUBw93Jlcm6siFjwe&scope=read_write"
  end
end