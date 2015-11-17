defmodule Dennis.RegistrationView do
  use Dennis.Web, :view
  
  alias Dennis.States

  def us_states do
    States.us_states
  end

  def fb_avatar_url(user_changeset) do
    "http://avatars.io/facebook/#{user_changeset.model.fb_id}?size=large"
  end

  def is_fb_user(user_changeset) do
    user_changeset.model.fb_id != nil
  end

  def cookie(conn, cookie_name) do
    conn.cookie[cookie_name]
  end

  def avatar_url(user_changeset) do
  	Dennis.Avatar.url({user_changeset.model.avatar, user_changeset.model})
  end

  def stripe_connect_url do
  	"https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_70DpQpxpPLuYLFAGUBw93Jlcm6siFjwe&scope=read_write"
  end

end