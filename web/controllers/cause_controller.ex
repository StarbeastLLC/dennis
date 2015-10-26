defmodule Dennis.CauseController do
  use Dennis.Web, :controller

  alias Dennis.Cause
  alias Dennis.User

  def index(conn, _params) do
    causes = Cause.global_causes_by_user_type("athlete")
    render(conn, "index.html", causes: causes)
  end

  def index_orgs(conn, _params) do
    users = User.get_orgs
    render(conn, "index-orgs.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)
    render(conn, "show.html", cause: cause)
  end

  def show_org(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show-org.html", user: user)
  end
end