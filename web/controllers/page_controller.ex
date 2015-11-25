defmodule Dennis.PageController do
  use Dennis.Web, :controller

  alias Dennis.User
  alias Dennis.AthleteController, as: Athlete
  alias Dennis.OrgController, as: Org

  alias Dennis.Mailer

  def index(conn, _params) do
    render conn, "index.html"
  end

  def invite(conn, _params) do
  	id = get_session(conn, :current_user)
    user = Repo.get!(User, id)

    cond do
    	user.user_type == "athlete" ->
    		Athlete.write_invite(conn, _params)
    	user.user_type == "org" ->
    		Org.write_invite(conn, _params)
    	user.user_type ->
    		redirect(conn, to: "/")
    end
  end

  def our_story(conn, _params) do
    render conn, "our-story.html"
  end

  def our_team(conn, _params) do
    render conn, "our-team.html"
  end

  def privacy(conn, _params) do
    render conn, "privacy.html"
  end
  
  def terms(conn, _params) do
    render conn, "terms.html"
  end

  def how(conn, _params) do
    render conn, "how.html"
  end

  def request_invite(conn, _params) do
    render conn, "request-invite.html"
  end

  def send_invite_request(conn, %{"request" => %{"email" => email}}) do
    Mailer.send_invite_request(email)
    conn
    |> put_flash(:info, "Thanks for your interest in MyMiles, we'll get back to you as soon as possible.")
    |> redirect(to: "/")
  end
end
