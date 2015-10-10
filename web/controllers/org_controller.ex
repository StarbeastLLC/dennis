defmodule Dennis.OrgController do
	use Dennis.Web, :controller 

	alias Dennis.Challenge
	alias Dennis.Cause

	plug :scrub_params, "cause" when action in [:create_cause]

	def show(conn, _params) do
		user_id = get_session(conn, :current_user)
    causes = Cause.user_causes(user_id)
		render(conn, "org.html", causes: causes)
	end

	def new_cause(conn, _params) do
	  changeset = Cause.changeset(%Cause{})
	  render(conn, "new-cause.html", changeset: changeset)
	end

	def create_cause(conn, %{"cause" => cause_params}) do
    user_id = get_session(conn, :current_user)

    changeset = Cause.changeset(%Cause{user_id: user_id}, cause_params)

    case Repo.insert(changeset) do
      {:ok, cause} ->
        conn
        |> put_flash(:info, "Cause created successfully.")
        |> redirect(to: "/dashboard")
      {:error, changeset} ->
        text conn, inspect(changeset)
    end
  end

  def show_cause(conn, %{"id" => id}) do
    cause = Repo.get(Cause, id)
    # cause = Repo.preload cause, :challenges
    render(conn, "cause-preview.html", cause: cause)
  end
	
end