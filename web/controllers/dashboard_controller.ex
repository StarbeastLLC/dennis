defmodule Dennis.DashboardController do
  use Dennis.Web, :controller

  alias Dennis.User
  alias Dennis.AthleteController, as: Athlete


  def index(conn, _params) do
  	id = get_session(conn, :current_user)
    user = Repo.get!(User, id)

    cond do
    	user.user_type == "athlete" ->
    		Athlete.show(conn, _params)
    	user.user_type == "org" ->
    		Org.show(conn, _params)
    	user.user_type ->
    		redirect(conn, to: "/")
    end

    text conn, inspect(user)
    # render(conn, "show.html", user: user)
  end


end