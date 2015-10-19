defmodule Dennis.User do
  use Dennis.Web, :model

  schema "users" do
    has_one  :permission, Dennis.Permission
    has_many :challenges, Dennis.Challenge
    has_many :causes,     Dennis.Cause
    has_many :donations,  Dennis.Donation

    field :email,         :string
    field :password,      :string, virtual: true
    field :password_conf, :string, virtual: true
    field :hashed_pswd,   :string
    field :reset_token,   :string
    field :is_admin,      :boolean, default: false
    field :is_active,     :boolean, default: false
    field :fb_id,         :string
    field :fb_token,      :string
    field :first_name,    :string
    field :last_name,     :string
    field :description,   :string
    field :country,       :string
    field :state,         :string
    field :address,       :string
    field :stripe_id,     :string
    field :user_type,     :string, default: "athlete"
    field :website,       :string
    field :org_name,      :string
    field :logo,          :binary
    field :photo_video,   :binary

    timestamps
  end

  @required_fields ~w(email hashed_pswd is_admin is_active first_name last_name country user_type)
  @optional_fields ~w(reset_token fb_id fb_token description state address stripe_id website org_name logo photo_video)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def register_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email password password_conf first_name last_name country user_type), @optional_fields)
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end

  def fb_auth_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email fb_id fb_token first_name last_name), ~w())
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> unique_constraint(:fb_id, on: Dennis.Repo)
    |> validate_format(:email, ~r/@/)
  end

  def full_name(user_id) do
    user = Dennis.Repo.one! from user in Dennis.User,
      where: user.id == ^user_id
    full_name = "#{user.first_name} #{user.last_name}"
  end
  
end
