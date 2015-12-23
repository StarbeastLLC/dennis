defmodule Dennis.ChallengeController do
  use Dennis.Web, :controller

  alias Dennis.Challenge

  def index(conn, _params) do
    challenges = Challenge.global_challenges
    render(conn, "index.html", challenges: challenges)
  end

  def show(conn, %{"id" => id}) do
    challenge = Challenge.get_challenge(id)
    donations = challenge.donations
    cond do
      Enum.count(challenge.donations) >= 4 ->
        donations = Enum.chunk(challenge.donations, 4, 1)
      Enum.count(challenge.donations) == 3 ->
        donations = Enum.chunk(challenge.donations, 3)
      Enum.count(challenge.donations) == 2 ->
        donations = Enum.chunk(challenge.donations, 2)
      Enum.count(challenge.donations) == 1 ->
        donations = Enum.chunk(challenge.donations, 1)
      :else ->
        []
    end
    render(conn, "show.html", challenge: challenge, donations: donations)
  end
end