defmodule Dennis.DonationTest do
  use Dennis.ModelCase

  alias Dennis.Donation

  @valid_attrs %{is_anonymous: true, miles_bought: 42, tip: 42, total_donated: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Donation.changeset(%Donation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Donation.changeset(%Donation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
