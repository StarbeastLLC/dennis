defmodule Dennis.CauseControllerTest do
  use Dennis.ConnCase

  alias Dennis.Cause
  @valid_attrs %{country: "some content", description: "some content", more_info: "some content", name: "some content", photo_video: "some content", state: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cause_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing causes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cause_path(conn, :new)
    assert html_response(conn, 200) =~ "New cause"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cause_path(conn, :create), cause: @valid_attrs
    assert redirected_to(conn) == cause_path(conn, :index)
    assert Repo.get_by(Cause, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cause_path(conn, :create), cause: @invalid_attrs
    assert html_response(conn, 200) =~ "New cause"
  end

  test "shows chosen resource", %{conn: conn} do
    cause = Repo.insert! %Cause{}
    conn = get conn, cause_path(conn, :show, cause)
    assert html_response(conn, 200) =~ "Show cause"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, cause_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cause = Repo.insert! %Cause{}
    conn = get conn, cause_path(conn, :edit, cause)
    assert html_response(conn, 200) =~ "Edit cause"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cause = Repo.insert! %Cause{}
    conn = put conn, cause_path(conn, :update, cause), cause: @valid_attrs
    assert redirected_to(conn) == cause_path(conn, :show, cause)
    assert Repo.get_by(Cause, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cause = Repo.insert! %Cause{}
    conn = put conn, cause_path(conn, :update, cause), cause: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cause"
  end

  test "deletes chosen resource", %{conn: conn} do
    cause = Repo.insert! %Cause{}
    conn = delete conn, cause_path(conn, :delete, cause)
    assert redirected_to(conn) == cause_path(conn, :index)
    refute Repo.get(Cause, cause.id)
  end
end
