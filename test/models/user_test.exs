defmodule Dennis.UserTest do
  use Dennis.ModelCase

  alias Dennis.User

  @valid_attrs %{address: "some content", country: "some content", description: "some content", email: "some content", fb_id: "some content", fb_token: "some content", first_name: "some content", hash: "some content", is_admin: true, last_name: "some content", logo: "some content", organization_name: "some content", password: "some content", photo_video: "some content", recovery_hash: "some content", state: "some content", stripe_id: "some content", user_type: "some content", username: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
