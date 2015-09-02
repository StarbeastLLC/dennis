defmodule Dennis.RaceControllerTest do
  use Dennis.ConnCase

  alias Dennis.Race
  @valid_attrs %{date: "2010-04-17 14:00:00", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, race_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing races"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, race_path(conn, :new)
    assert html_response(conn, 200) =~ "New race"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, race_path(conn, :create), race: @valid_attrs
    assert redirected_to(conn) == race_path(conn, :index)
    assert Repo.get_by(Race, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, race_path(conn, :create), race: @invalid_attrs
    assert html_response(conn, 200) =~ "New race"
  end

  test "shows chosen resource", %{conn: conn} do
    race = Repo.insert! %Race{}
    conn = get conn, race_path(conn, :show, race)
    assert html_response(conn, 200) =~ "Show race"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, race_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    race = Repo.insert! %Race{}
    conn = get conn, race_path(conn, :edit, race)
    assert html_response(conn, 200) =~ "Edit race"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    race = Repo.insert! %Race{}
    conn = put conn, race_path(conn, :update, race), race: @valid_attrs
    assert redirected_to(conn) == race_path(conn, :show, race)
    assert Repo.get_by(Race, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    race = Repo.insert! %Race{}
    conn = put conn, race_path(conn, :update, race), race: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit race"
  end

  test "deletes chosen resource", %{conn: conn} do
    race = Repo.insert! %Race{}
    conn = delete conn, race_path(conn, :delete, race)
    assert redirected_to(conn) == race_path(conn, :index)
    refute Repo.get(Race, race.id)
  end
end
