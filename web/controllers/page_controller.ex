defmodule Dennis.PageController do
  use Dennis.Web, :controller

  alias Dennis.User
  alias Dennis.AthleteController, as: Athlete
  alias Dennis.OrgController, as: Org

  def index(conn, _params) do
    render conn, "index.html"
  end

  def invite(conn, _params) do
  	id = get_session(conn, :current_user)
    user = Repo.get!(User, id)

    cond do
    	user.user_type == "athlete" ->
    		Athlete.invite(conn, _params)
    	user.user_type == "org" ->
    		Org.invite(conn, _params)
    	user.user_type ->
    		redirect(conn, to: "/")
    end
  end
  
end
