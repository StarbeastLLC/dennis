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
    field :hash,          :string
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
    field :user_type,     :string
    field :website,       :string
    field :org_name,      :string
    field :logo,          :binary
    field :photo_video,   :binary

    timestamps
  end

  @required_fields ~w(first_name last_name username description email photo_video country state address password hash recovery_hash fb_id fb_token stripe_id user_type organization_name website logo is_admin )
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
