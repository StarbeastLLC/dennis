defmodule Dennis.CauseView do
  use Dennis.Web, :view

  def tweet_cause(conn, cause) do
  	"https://twitter.com/intent/tweet?text=#{cause.name}&url=#{org_path(conn, :show_cause, cause)}"
  end

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def photo_url(cause) do
    Dennis.CausePhoto.url({cause.photo1, cause})
  end
end
