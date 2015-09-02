defmodule Dennis.CauseTest do
  use Dennis.ModelCase

  alias Dennis.Cause

  @valid_attrs %{country: "some content", description: "some content", more_info: "some content", name: "some content", photo_video: "some content", state: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cause.changeset(%Cause{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cause.changeset(%Cause{}, @invalid_attrs)
    refute changeset.valid?
  end
end
