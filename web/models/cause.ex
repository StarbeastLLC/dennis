defmodule Dennis.Cause do
  use Dennis.Web, :model

  alias Dennis.User

  schema "causes" do
    belongs_to :user, Dennis.User
    has_many :challenges, Dennis.Challenge
    field :name, :string
    field :country, :string
    field :state, :string
    field :description, :string
    field :more_info, :string
    field :photo_video, :binary

    timestamps
  end

  @required_fields ~w(name country state description more_info user_id)
  @optional_fields ~w(photo_video)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def user_causes(user_id) do
    Dennis.Repo.all from cause in Dennis.Cause,
     where: cause.user_id == ^user_id,
     preload: [:challenges, :user]
  end

  def global_causes_by_user_type(user_type) do
    Dennis.Repo.all from cause in Dennis.Cause,
      join: user in User, on: cause.user_id == user.id,
      where: user.user_type == ^user_type,
      preload: []
  end

  def challenge_cause(cause_id) do
    Dennis.Repo.get_by(Cause, id: cause_id)
  end

  def global_causes do
    Dennis.Repo.all from cause in Dennis.Cause,
    preload: [:challenges, :user]
  end
  
end
