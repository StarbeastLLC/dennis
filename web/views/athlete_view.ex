defmodule Dennis.AthleteView do
  use Dennis.Web, :view

  alias Dennis.Cause
  alias Dennis.Repo

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def photo_url(cause) do
    Dennis.CausePhoto.url({cause.photo1, cause})
  end

  def cause_photo(id) do
    cause = Repo.get!(Cause, id)
    Dennis.CausePhoto.url({cause.photo1, cause})
  end

  def cause_name(id) do
    cause = Repo.get!(Cause, id)
    cause.name
  end
  
end