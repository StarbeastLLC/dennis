defmodule Dennis.AthleteController do
	use Dennis.Web, :controller
  import Ecto.UUID

  alias Dennis.Cause
	alias Dennis.Challenge
  alias Dennis.User

  alias Dennis.Mailer

	plug :scrub_params, "challenge" when action in [:create_challenge]

	def show(conn, _params) do
		user_id = get_session(conn, :current_user)
    challenges = Challenge.user_challenges(user_id)
    causes = Cause.user_causes(user_id)
		render(conn, "athlete.html", challenges: challenges, causes: causes)
	end

	def new_challenge(conn, _params) do
		changeset = Challenge.changeset(%Challenge{})
    causes = Cause.global_causes
	  render(conn, "new-challenge.html", [changeset: changeset, causes: causes])
	end

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
    challenge = Repo.get(Challenge, id)
    render(conn, "challenge-preview.html", challenge: challenge)
  end

  def write_invite(conn, _params) do
    render conn, "athlete-invite.html"
  end

  def invite(conn, %{"invitation" => %{"email" => email}}) do
    subject = "An athlete wants to raise money for you"
    user_id = get_session(conn, :current_user)
    user_name = User.full_name(user_id)
    token = Ecto.UUID.generate
    Mailer.send_invitation(subject, user_name, email, token)
    conn
    |> put_flash(:info, "Your invitation was sent")
    |> redirect to: "/dashboard"
  end
  
end