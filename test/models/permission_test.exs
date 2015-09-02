defmodule Dennis.PermissionTest do
  use Dennis.ModelCase

  alias Dennis.Permission

  @valid_attrs %{name: "some content", resource_id: 42, resource_type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Permission.changeset(%Permission{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Permission.changeset(%Permission{}, @invalid_attrs)
    refute changeset.valid?
  end
end
