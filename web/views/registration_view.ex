defmodule Dennis.RegistrationView do
  use Dennis.Web, :view


  def cookie(conn, cookie_name) do
    conn.cookie[cookie_name]
  end

  def avatar_url(user_changeset) do
  	Dennis.Avatar.url({user_changeset.model.avatar, user_changeset.model})
  end

end
