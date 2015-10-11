defmodule Dennis.CauseController do
  use Dennis.Web, :controller

  alias Dennis.Cause

  def index(conn, _params) do
    causes = Repo.all(Cause)
    render(conn, "index.html", causes: causes)
  end

  def show(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)
    render(conn, "show.html", cause: cause)
  end
end