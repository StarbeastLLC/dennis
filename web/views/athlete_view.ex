defmodule Dennis.AthleteView do
  use Dennis.Web, :view

  alias Dennis.Cause
  alias Dennis.Repo
  alias Dennis.User

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def is_athlete?(cause_id) do
    cause = Cause.cause_with_user(cause_id)
    if cause.user.user_type == "athlete" do
      true
    else
      false
    end
  end

  def org_photo(cause_id) do
    user = User.get_by_cause(cause_id)
    Dennis.Avatar.url({user.avatar, user})
  end

  def photo_url(cause) do
    Dennis.CausePhoto.url({cause.photo1, cause})
  end

  def amount_donated(challenge_id) do
    amount = Donation.amount_donated_to_challenge(challenge_id)
    if amount == nil do
    else
      "$ #{amount}"
    end
  end

  def challenge_main_photo(challenge) do
    if challenge.photo1 do
      Dennis.ChallengePhoto.url({challenge.photo1, challenge})
    else
      "/images/c1.jpg"
    end
  end

  def cause_photo(id) do
    cause = Repo.get!(Cause, id)
    Dennis.CausePhoto.url({cause.photo1, cause})
  end

  def cause_name(id) do
    cause = Repo.get!(Cause, id)
    cause.name
  end

  def is_fb_user(user) do
    user.fb_id != nil
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
  
end