defmodule Dennis.CauseController do
  use Dennis.Web, :controller

  alias Dennis.Cause
  alias Dennis.User

  def index(conn, _params) do
    causes = Cause.global_causes_by_user_type("athlete")
    render(conn, "index.html", causes: causes)
  end

  def index_orgs(conn, _params) do
    causes = Cause.global_causes_by_user_type("org")
    render(conn, "index-orgs.html", causes: causes)
  end

  def show(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)
    render(conn, "show.html", cause: cause)
  end

  def show_org(conn, %{"id" => id}) do
    cause = Cause.get_cause_with_user(id)
    render(conn, "show-org.html", cause: cause)
  end
end