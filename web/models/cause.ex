defmodule Dennis.Cause do
  use Dennis.Web, :model
  use Arc.Ecto.Model

  alias Dennis.User

  schema "causes" do
    belongs_to :user, Dennis.User
    has_many :challenges, Dennis.Challenge
    field :name, :string
    field :country, :string, default: "US"
    field :state, :string
    field :description, :string
    field :more_info, :string

    field :photo1,  Dennis.CausePhoto.Type
    field :photo2,  Dennis.CausePhoto.Type
    field :photo3,  Dennis.CausePhoto.Type
    field :photo4,  Dennis.CausePhoto.Type
    field :photo5,  Dennis.CausePhoto.Type

    timestamps
  end

  @required_fields ~w(name country state description user_id)
  @optional_fields ~w(more_info)

  @required_file_fields ~w(photo1)
  @optional_file_fields ~w(photo2 photo3 photo4 photo5)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  @doc """
  Creates a changeset for saving a cause uploaded photos.

  `cause_photos` must be a list of Plug.Upload structs.
  A maximum of 5 photos will be allowed.
  """
  def changeset_photos(model, cause_photos) do
    params = 
      cause_photos
      |> Enum.take(5)
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({photo, index}, params) ->
        Dict.put(params, "photo#{index+1}", photo)
      end)

    model
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end  

  def user_causes(user_id) do
    Dennis.Repo.all from cause in Dennis.Cause,
     where: cause.user_id == ^user_id,
     preload: [:challenges, :user]
  end

  def cause_with_user(cause_id) do
    Dennis.Repo.one from cause in Dennis.Cause,
      where: cause.id == ^cause_id,
      preload: [:user]
  end

  def global_causes_by_user_type(user_type) do
    Dennis.Repo.all from cause in Dennis.Cause,
      join: user in User, on: cause.user_id == user.id,
      where: user.user_type == ^user_type and user.stripe_id != "",
      preload: [:user]
  end

  def challenge_cause(cause_id) do
    Dennis.Repo.get_by(Cause, id: cause_id)
  end

  def get_cause_with_user(cause_id) do
    Dennis.Repo.one from cause in Dennis.Cause,
    where: cause.id == ^cause_id,
    preload: [:challenges, :user]
  end  

  def global_causes do
    Dennis.Repo.all from cause in Dennis.Cause,
    preload: [:challenges, :user]
  end
  
end
