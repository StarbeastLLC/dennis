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
    user = Repo.get!(User, user_id)
    challenges = Challenge.user_challenges(user_id)
    causes = Cause.user_causes(user_id)
		render(conn, "athlete.html", challenges: challenges, causes: causes, user: user)
	end

  def show_cause_challenges(conn, %{"id" => cause_id}) do
    user_id = get_session(conn, :current_user)
    user = Repo.get!(User, user_id)
    cause = Repo.get!(Cause, cause_id)
    challenges = Challenge.cause_challenges(cause_id)
    render(conn, "cause.html", challenges: challenges, cause: cause, user: user)
  end
  
  def new_challenge(conn, %{"cause_id" => id}) do
    render_new_challenge conn, Challenge.changeset(%Challenge{cause_id: id})
  end

  def new_challenge(conn, _params) do
    render_new_challenge conn, Challenge.changeset(%Challenge{})
  end

  defp render_new_challenge(conn, challenge_changeset) do
    user_id = get_session(conn, :current_user)
    user = Repo.get!(User, user_id)
    org_causes = Cause.global_causes_by_user_type("org")
    athlete_causes = Cause.global_causes_by_user_type("athlete")
    render(conn, "new-challenge.html", [changeset: challenge_changeset, org_causes: org_causes, athlete_causes: athlete_causes, user: user])
  end

  def create_challenge(conn, %{"challenge" => challenge_params}) do
    user_id = get_session(conn, :current_user)

    changeset = Challenge.changeset(%Challenge{user_id: user_id}, challenge_params)
    photos = Map.get(challenge_params, "photos", [])

    full_changeset = 
      changeset
      |> Challenge.changeset_photos(photos)

    if full_changeset.valid? do
        changeset
        |> Repo.insert!
        |> Challenge.changeset_photos(photos)
        |> Repo.update

        conn
        |> put_flash(:info, "Your challenge has been created successfully!")
        |> redirect(to: "/dashboard")
    else
        render_new_challenge conn, full_changeset
    end
  end

  def show_challenge(conn, %{"id" => id}) do
    challenge = Repo.get(Challenge, id)
    render(conn, "challenge-preview.html", challenge: challenge)
  end

  def write_invite(conn, _params) do
    render conn, "athlete-invite.html"
  end

  def invite(conn, %{"invitation" => %{"email" => email, "message" => message, "org_name" => org_name}}) do
    subject = "An athlete wants to raise money for you"
    user_id = get_session(conn, :current_user)
    athlete  = User.find_by_id(user_id)

    token = Ecto.UUID.generate
    user_params = %{"email" => email, "reset_token" => token, "user_type" => "org"}
    changeset = User.invited_org_changeset(%User{}, user_params)
    if changeset.valid? do
      {:ok, user} = Repo.insert(changeset)
      Mailer.send_invitation(subject, athlete, email, token, message, org_name)
      conn
      |> put_flash(:info, "Great! Your invitation was sent to the charity.")
      |> redirect to: "/dashboard"
    else
      conn
      |> put_flash(:error, "Oops! This charity has already been invited.")
    end
  
  end
  
end