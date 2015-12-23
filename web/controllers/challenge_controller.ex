defmodule Dennis.ChallengeController do
  use Dennis.Web, :controller

  alias Dennis.Challenge

  def index(conn, _params) do
    challenges = Challenge.global_challenges
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Challenge.get_challenge(id)
    donations = Enum.chunk(challenge.donations, 4, 1)
    render(conn, "show.html", challenge: challenge, donations: donations)
  end
end