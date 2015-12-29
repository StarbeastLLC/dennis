defmodule Dennis.Challenge do
  use Dennis.Web, :model
  use Arc.Ecto.Model

  alias Ecto.Date
  alias Dennis.Race

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
    field :race_fee, :integer

    field :photo1,  Dennis.ChallengePhoto.Type
    field :photo2,  Dennis.ChallengePhoto.Type
    field :photo3,  Dennis.ChallengePhoto.Type
    field :photo4,  Dennis.ChallengePhoto.Type
    field :photo5,  Dennis.ChallengePhoto.Type
    field :video, :string

    timestamps
  end

  @required_fields ~w(name description mile_price is_active race cause_id user_id)
  @optional_fields ~w(video will_redeem_fee status race_fee)

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

  def finish_challenges do
    expired_challenges = from challenge in Dennis.Challenge,
    join: race in Race, on: race.challenge_id == challenge.id,
    where: race.date < date_add(^today, 1, "day") and challenge.status != "finished",
    # the extra where ensures the update applies to joined rows,
    # without this, it updates every challenge
    where: challenge.id == fragment("challenges.id")
    Dennis.Repo.update_all(expired_challenges, set: [status: "finished"]) 
  end

  defp today do
    Date.utc
  end

end
