defmodule Dennis.PermissionController do
  use Dennis.Web, :controller

  alias Dennis.Permission

  plug :scrub_params, "permission" when action in [:create, :update]

  def index(conn, _params) do
    permissions = Repo.all(Permission)
    render(conn, "index.html", permissions: permissions)
  end

  def new(conn, _params) do
    changeset = Permission.changeset(%Permission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"permission" => permission_params}) do
    changeset = Permission.changeset(%Permission{}, permission_params)

    case Repo.insert(changeset) do
      {:ok, _permission} ->
        conn
        |> put_flash(:info, "Permission created successfully.")
        |> redirect(to: permission_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    permission = Repo.get!(Permission, id)
    render(conn, "show.html", permission: permission)
  end

  def edit(conn, %{"id" => id}) do
    permission = Repo.get!(Permission, id)
    changeset = Permission.changeset(permission)
    render(conn, "edit.html", permission: permission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "permission" => permission_params}) do
    permission = Repo.get!(Permission, id)
    changeset = Permission.changeset(permission, permission_params)

    case Repo.update(changeset) do
      {:ok, permission} ->
        conn
        |> put_flash(:info, "Permission updated successfully.")
        |> redirect(to: permission_path(conn, :show, permission))
      {:error, changeset} ->
        render(conn, "edit.html", permission: permission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    permission = Repo.get!(Permission, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(permission)

    conn
    |> put_flash(:info, "Permission deleted successfully.")
    |> redirect(to: permission_path(conn, :index))
  end
end
