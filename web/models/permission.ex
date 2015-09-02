defmodule Dennis.Permission do
  use Dennis.Web, :model

  schema "permissions" do
    belongs_to :user, Dennis.User
    field :name, :string
    field :resource_id, :integer
    field :resource_type, :string

    timestamps
  end

  @required_fields ~w(name resource_id resource_type)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
