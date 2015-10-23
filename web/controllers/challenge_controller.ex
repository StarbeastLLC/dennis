defmodule Dennis.ChallengeController do
  use Dennis.Web, :controller

  alias Dennis.Challenge

  def index(conn, _params) do
    challenges = Repo.all(Challenge)
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Challenge.get_challenge(id)
    render(conn, "show.html", challenge: challenge)
  end
end