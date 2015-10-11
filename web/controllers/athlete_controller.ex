defmodule Dennis.AthleteController do
	use Dennis.Web, :controller

  alias Dennis.Cause
	alias Dennis.Challenge

	plug :scrub_params, "challenge" when action in [:create_challenge]

	def show(conn, _params) do
		user_id = get_session(conn, :current_user)
    challenges = Challenge.user_challenges(user_id)
		render(conn, "athlete.html", challenges: challenges)
	end

	def new_challenge(conn, _params) do
		changeset = Challenge.changeset(%Challenge{})
    causes = Cause.global_causes
	  render(conn, "new-challenge.html", [changeset: changeset, causes: causes])
	end

  # def new_challenge(conn, _params) do
  #   changeset = Ecto.Model.build(cause, :challenges)
  #   render(conn, "new-challenge.html", changeset: changeset)
  # end

  def create_challenge(conn, %{"challenge" => challenge_params}) do
    user_id = get_session(conn, :current_user)

    changeset = Challenge.changeset(%Challenge{user_id: user_id}, challenge_params)

    case Repo.insert(changeset) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: "/dashboard")
      {:error, changeset} ->
        text conn, inspect(changeset)
    end
  end

  def show_challenge(conn, %{"id" => id}) do
    challenge = Repo.get!(Challenge, id)
    challenge = Repo.preload challenge, :donations
    render(conn, "challenge-preview.html", challenge: challenge)
  end

end