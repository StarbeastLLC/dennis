defmodule Dennis.Challenge do
  use Dennis.Web, :model
  use Arc.Ecto.Model

  schema "challenges" do
    belongs_to :user, Dennis.User
    belongs_to :cause, Dennis.Cause
    has_one :race, Dennis.Race
    has_many :donations, Dennis.Donation
    field :name, :string
    field :description, :string
    field :shares_count, :integer
    field :mile_price, :integer
    field :is_active, :boolean, default: false
    field :will_redeem_fee, :boolean
    field :status, :string, default: "active-challenge"

    field :photo1,  Dennis.ChallengePhoto.Type
    field :photo2,  Dennis.ChallengePhoto.Type
    field :photo3,  Dennis.ChallengePhoto.Type
    field :photo4,  Dennis.ChallengePhoto.Type
    field :photo5,  Dennis.ChallengePhoto.Type
    field :video, :string

    timestamps
  end

  @required_fields ~w(name description mile_price is_active race cause_id user_id)
  @optional_fields ~w(video will_redeem_fee status)

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

  def changeset_photos(model, uploaded_photos) do
    params = 
      uploaded_photos
      |> Enum.take(5)
      |> Enum.with_index
      |> Enum.reduce(%{}, fn({photo, index}, params) ->
        Dict.put(params, "photo#{index+1}", photo)
      end)

    model
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end

  def user_challenges(user_id) do
    Dennis.Repo.all from challenge in Dennis.Challenge,
      where: challenge.user_id == ^user_id,
      preload: [:user, :cause, :race, :donations]
  end

  def cause_challenges(cause_id) do
    Dennis.Repo.all from challenge in Dennis.Challenge,
      where: challenge.cause_id == ^cause_id,
      preload: [:user, :cause, :race, :donations]
  end

  def get_challenge(id) do
    Dennis.Repo.one from challenge in Dennis.Challenge,
    where: challenge.id == ^id,
    preload: [:user, {:cause, [:user]}, :race, :donations]
  end

  def global_challenges do
    Dennis.Repo.all from challenge in Dennis.Challenge,
      preload: [:user, :cause, :race]
  end

end
