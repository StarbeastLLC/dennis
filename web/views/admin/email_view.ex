defmodule Dennis.Admin.EmailView do
  use Dennis.Web, :view

  def avatar_url(user) do
    Dennis.Avatar.url({user.avatar, user})
  end

  def fb_avatar_url(user) do
    "http://avatars.io/facebook/#{user.fb_id}?size=large"
  end

  def is_fb_user(user) do
    user.fb_id != nil
  end
end
