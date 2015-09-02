defmodule Dennis.Race do
  use Dennis.Web, :model

  schema "races" do
    belongs_to :challenge, Dennis.Challenge
    field :name, :string
    field :date, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(name date)
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
