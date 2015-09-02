defmodule Dennis.DonationController do
  use Dennis.Web, :controller

  alias Dennis.Donation

  plug :scrub_params, "donation" when action in [:create, :update]

  def index(conn, _params) do
    donations = Repo.all(Donation)
    render(conn, "index.html", donations: donations)
  end

  def new(conn, _params) do
    changeset = Donation.changeset(%Donation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"donation" => donation_params}) do
    changeset = Donation.changeset(%Donation{}, donation_params)

    case Repo.insert(changeset) do
      {:ok, _donation} ->
        conn
        |> put_flash(:info, "Donation created successfully.")
        |> redirect(to: donation_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    donation = Repo.get!(Donation, id)
    render(conn, "show.html", donation: donation)
  end

  def edit(conn, %{"id" => id}) do
    donation = Repo.get!(Donation, id)
    changeset = Donation.changeset(donation)
    render(conn, "edit.html", donation: donation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "donation" => donation_params}) do
    donation = Repo.get!(Donation, id)
    changeset = Donation.changeset(donation, donation_params)

    case Repo.update(changeset) do
      {:ok, donation} ->
        conn
        |> put_flash(:info, "Donation updated successfully.")
        |> redirect(to: donation_path(conn, :show, donation))
      {:error, changeset} ->
        render(conn, "edit.html", donation: donation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation = Repo.get!(Donation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(donation)

    conn
    |> put_flash(:info, "Donation deleted successfully.")
    |> redirect(to: donation_path(conn, :index))
  end
end
