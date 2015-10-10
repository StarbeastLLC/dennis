defmodule Dennis.Challenge do
  use Dennis.Web, :model

  schema "challenges" do
    belongs_to :user, Dennis.User
    belongs_to :cause, Dennis.Cause
    belongs_to :race, Dennis.Race
    has_many :donations, Dennis.Donation
    field :name, :string
    field :description, :string
    field :photo, :binary
    field :shares_count, :integer
    field :mile_price, :integer
    field :is_active, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name description mile_price is_active race_id cause_id user_id)
  @optional_fields ~w(photo shares_count)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def user_challenges(user_id) do
    Dennis.Repo.all from challenge in Dennis.Challenge,
      where: challenge.user_id == ^user_id
  end
end
