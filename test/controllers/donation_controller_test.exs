defmodule Dennis.DonationControllerTest do
  use Dennis.ConnCase

  alias Dennis.Donation
  @valid_attrs %{is_anonymous: true, miles_bought: 42, tip: 42, total_donated: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, donation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing donations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, donation_path(conn, :new)
    assert html_response(conn, 200) =~ "New donation"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, donation_path(conn, :create), donation: @valid_attrs
    assert redirected_to(conn) == donation_path(conn, :index)
    assert Repo.get_by(Donation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, donation_path(conn, :create), donation: @invalid_attrs
    assert html_response(conn, 200) =~ "New donation"
  end

  test "shows chosen resource", %{conn: conn} do
    donation = Repo.insert! %Donation{}
    conn = get conn, donation_path(conn, :show, donation)
    assert html_response(conn, 200) =~ "Show donation"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, donation_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    donation = Repo.insert! %Donation{}
    conn = get conn, donation_path(conn, :edit, donation)
    assert html_response(conn, 200) =~ "Edit donation"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    donation = Repo.insert! %Donation{}
    conn = put conn, donation_path(conn, :update, donation), donation: @valid_attrs
    assert redirected_to(conn) == donation_path(conn, :show, donation)
    assert Repo.get_by(Donation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    donation = Repo.insert! %Donation{}
    conn = put conn, donation_path(conn, :update, donation), donation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit donation"
  end

  test "deletes chosen resource", %{conn: conn} do
    donation = Repo.insert! %Donation{}
    conn = delete conn, donation_path(conn, :delete, donation)
    assert redirected_to(conn) == donation_path(conn, :index)
    refute Repo.get(Donation, donation.id)
  end
end
