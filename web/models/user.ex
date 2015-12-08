defmodule Dennis.User do
  use Dennis.Web, :model
  use Arc.Ecto.Model

  alias Dennis.Repo
  alias Dennis.Mailer
  alias Dennis.Cause

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
    field :country,       :string, default: "US"
    field :state,         :string
    field :address,       :string
    field :stripe_id,     :string
    field :user_type,     :string, default: "athlete"
    field :website,       :string
    field :org_name,      :string
    field :avatar,        Dennis.Avatar.Type

    timestamps
  end

  @required_fields ~w(email hashed_pswd is_admin is_active first_name last_name country user_type)
  @optional_fields ~w(reset_token fb_id fb_token description state address stripe_id website org_name)

  @required_file_fields ~w(avatar)
  @optional_file_fields ~w()


  @optional_org_fields ~w(reset_token fb_id fb_token stripe_id)

  
  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def stripe_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(stripe_id), ~w())
  end

  def register_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email password password_conf first_name last_name country user_type), @optional_fields)
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end

  def change_password_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(password hashed_pswd), ~w()) # pending
    |> validate_length(:password, min: 5)
  end

  def register_org_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email password password_conf org_name country user_type description website address state), @optional_org_fields)
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)    
  end

  def invited_org_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email reset_token user_type), ~w())
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
  end

  def profile_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email first_name last_name user_type), @optional_fields)
    |> validate_format(:email, ~r/@/)
  end

  def update_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email first_name last_name user_type), @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> cast_attachments(params, ~w(), ~w(avatar))
  end

  def fb_auth_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email fb_id first_name last_name), ~w(fb_token))
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> unique_constraint(:fb_id, on: Dennis.Repo)
    |> validate_format(:email, ~r/@/)
  end

  def full_name(user_id) do
    user = Dennis.Repo.one! from user in Dennis.User,
      where: user.id == ^user_id
    full_name = "#{user.first_name} #{user.last_name}"
  end
  
  def get_orgs do
    Dennis.Repo.all from user in Dennis.User,
    where: user.user_type == "org"
  end

  def get_by_cause(cause_id) do
    Dennis.Repo.one from user in Dennis.User,
      join: cause in Cause, on: user.cause_id == ^cause_id,
      where: user.user_type == "org"
  end

  def get_by_email(email) do
    Dennis.Repo.one from user in Dennis.User,
    where: user.email == ^email  
  end
  
  def find_by_id(user_id) do
    Dennis.Repo.one from user in Dennis.User,
    where: user.id == ^user_id
  end

  def validate_token(token) do
    Dennis.Repo.one from user in Dennis.User,
    where: user.reset_token == ^token
  end

  def donor_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email reset_token), ~w(user_type))
    |> unique_constraint(:email, on: Dennis.Repo, downcase: true)
    |> validate_format(:email, ~r/@/)
  end

  def create_donor(email) do
    user = Repo.insert! donor_changeset(%Dennis.User{}, %{
      email: email,
      reset_token: Ecto.UUID.generate
    })
    Mailer.send_donor_invitation(user)
    user
  end

end
