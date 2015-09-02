defmodule Dennis.CauseController do
  use Dennis.Web, :controller

  alias Dennis.Cause

  plug :scrub_params, "cause" when action in [:create, :update]

  def index(conn, _params) do
    causes = Repo.all(Cause)
    render(conn, "index.html", causes: causes)
  end

  def new(conn, _params) do
    changeset = Cause.changeset(%Cause{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cause" => cause_params}) do
    changeset = Cause.changeset(%Cause{}, cause_params)

    case Repo.insert(changeset) do
      {:ok, _cause} ->
        conn
        |> put_flash(:info, "Cause created successfully.")
        |> redirect(to: cause_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)
    render(conn, "show.html", cause: cause)
  end

  def edit(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)
    changeset = Cause.changeset(cause)
    render(conn, "edit.html", cause: cause, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cause" => cause_params}) do
    cause = Repo.get!(Cause, id)
    changeset = Cause.changeset(cause, cause_params)

    case Repo.update(changeset) do
      {:ok, cause} ->
        conn
        |> put_flash(:info, "Cause updated successfully.")
        |> redirect(to: cause_path(conn, :show, cause))
      {:error, changeset} ->
        render(conn, "edit.html", cause: cause, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cause = Repo.get!(Cause, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cause)

    conn
    |> put_flash(:info, "Cause deleted successfully.")
    |> redirect(to: cause_path(conn, :index))
  end
end
