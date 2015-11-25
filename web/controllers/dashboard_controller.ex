defmodule Dennis.DashboardController do
  use Dennis.Web, :controller

  alias Dennis.User
  alias Dennis.AthleteController, as: Athlete
  alias Dennis.OrgController, as: Org


  def index(conn, _params) do
  	id = get_session(conn, :current_user)
    unless id do
      conn
      |> put_flash(:error, "You need to login to continue.")
      |> redirect(to: "/")
    end
    user = Repo.get!(User, id)

    cond do
    	user.user_type == "athlete" ->
    		Athlete.show(conn, _params)
    	user.user_type == "org" ->
    		Org.show(conn, _params)
    	:else ->
    		redirect(conn, to: "/")
    end
  end

end