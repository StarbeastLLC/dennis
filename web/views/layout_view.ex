defmodule Dennis.LayoutView do
  use Dennis.Web, :view

  alias Dennis.Session

  def has_org_stripe?(conn) do
  	user = current_user(conn)
  	cond do
  		user.user_type == "org" && user.stripe_id == nil ->
  			false
  		true ->
  			true
  	end
  end
end
