defmodule Dennis.Challenge do
  use Dennis.Web, :model

  schema "challenges" do
    belongs_to :user, Dennis.User
    belongs_to :cause, Dennis.Cause
    has_many :donations, Dennis.Donation
    has_one :race, Dennis.Race
    field :name, :string
    field :description, :string
    field :photo, :binary
    field :shares_count, :integer
    field :miles, :integer
    field :mile_price, :integer
    field :is_active, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name description photo shares_count miles mile_price is_active)
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
