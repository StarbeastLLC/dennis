defmodule Dennis.Race do
  use Dennis.Web, :model

  schema "races" do
    belongs_to :challenge, Dennis.Challenge
    field :name, :string
    field :miles, :integer
    field :date, Ecto.DateTime
    field :type, :string

    timestamps
  end

  @required_fields ~w(name date miles)
  @optional_fields ~w(type)

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
