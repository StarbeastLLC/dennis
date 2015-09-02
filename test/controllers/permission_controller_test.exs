defmodule Dennis.PermissionControllerTest do
  use Dennis.ConnCase

  alias Dennis.Permission
  @valid_attrs %{name: "some content", resource_id: 42, resource_type: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, permission_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing permissions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, permission_path(conn, :new)
    assert html_response(conn, 200) =~ "New permission"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, permission_path(conn, :create), permission: @valid_attrs
    assert redirected_to(conn) == permission_path(conn, :index)
    assert Repo.get_by(Permission, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, permission_path(conn, :create), permission: @invalid_attrs
    assert html_response(conn, 200) =~ "New permission"
  end

  test "shows chosen resource", %{conn: conn} do
    permission = Repo.insert! %Permission{}
    conn = get conn, permission_path(conn, :show, permission)
    assert html_response(conn, 200) =~ "Show permission"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, permission_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    permission = Repo.insert! %Permission{}
    conn = get conn, permission_path(conn, :edit, permission)
    assert html_response(conn, 200) =~ "Edit permission"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    permission = Repo.insert! %Permission{}
    conn = put conn, permission_path(conn, :update, permission), permission: @valid_attrs
    assert redirected_to(conn) == permission_path(conn, :show, permission)
    assert Repo.get_by(Permission, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    permission = Repo.insert! %Permission{}
    conn = put conn, permission_path(conn, :update, permission), permission: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit permission"
  end

  test "deletes chosen resource", %{conn: conn} do
    permission = Repo.insert! %Permission{}
    conn = delete conn, permission_path(conn, :delete, permission)
    assert redirected_to(conn) == permission_path(conn, :index)
    refute Repo.get(Permission, permission.id)
  end
end
