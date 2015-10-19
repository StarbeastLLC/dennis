defmodule Dennis.Admin.EmailController do
  use Dennis.Web, :controller

  def athlete_invite_email(conn, _params) do
  	render conn, "athlete-invite-email.html"
  end
  
end