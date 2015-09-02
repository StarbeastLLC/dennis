defmodule Dennis.ChallengeTest do
  use Dennis.ModelCase

  alias Dennis.Challenge

  @valid_attrs %{description: "some content", is_active: true, mile_price: 42, miles: 42, name: "some content", photo: "some content", shares_count: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Challenge.changeset(%Challenge{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Challenge.changeset(%Challenge{}, @invalid_attrs)
    refute changeset.valid?
  end
end
