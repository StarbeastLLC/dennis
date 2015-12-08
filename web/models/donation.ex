defmodule Dennis.Donation do
  use Dennis.Web, :model

  alias Dennis.Repo
  alias Dennis.User
  alias Commerce.Billing
  alias Commerce.Billing.Response, as: BillingResponse  

  schema "donations" do
    belongs_to :challenge, Dennis.Challenge
    belongs_to :user, Dennis.User

    field :transaction_token, :string
    field :authorization_token, :string
    field :miles_bought, :integer
    field :tip, :integer
    field :total_donated, :integer
    field :is_anonymous, :boolean, default: false
    field :name, :string

    timestamps
  end

  @required_fields ~w(miles_bought total_donated transaction_token challenge_id)
  @optional_fields ~w(authorization_token user_id name tip)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  defp total_donated(challenge, %{"miles_bought" => miles_bought}) do
    total = String.to_integer(miles_bought) * challenge.mile_price
    total
  end

  def charge_donation(challenge, donation_params, stripe_email) do
    donation_changeset =  changeset(%Dennis.Donation{
           challenge_id: challenge.id,
           total_donated: total_donated(challenge, donation_params)
        }, donation_params)

    if donation_changeset.valid? do
      case stripe_billing(challenge, donation_changeset, stripe_email) do
        {:ok, %BillingResponse{authorization: authorization_token}} ->
          donation = create!(challenge, donation_changeset, stripe_email, authorization_token)
          {:ok, donation}

        {:error, %BillingResponse{reason: reason}} = error ->
          IO.puts ">>>>>> BILL ERR: #{inspect(error)}"
          {:error, reason, donation_changeset}
      end      
    else
      {:error, donation_changeset.errors, donation_changeset}
    end
  end

  defp create!(challenge, donation_changeset, stripe_email, authorization_token) do
    user = Repo.get_by(User, email: stripe_email) || User.create_donor(stripe_email)
    Repo.insert! changeset(donation_changeset, %{
      user_id: user.id,
      authorization_token: authorization_token
    })
  end

  defp stripe_billing(challenge, donation_changeset, stripe_email) do
    import Ecto.Changeset, only: [get_field: 2]
    application_fee = Application.get_env(:dennis, :stripe)[:application_fee]
    org_stripe_id = challenge.cause.user.stripe_id # not ruby, tho
    charge_description = "MYMYLES // #{challenge.name}"

    Billing.authorize(:stripe, 
      get_field(donation_changeset, :total_donated) * 100, # Stripe uses cents
      get_field(donation_changeset, :transaction_token), 
      capture: true,
      destination: org_stripe_id,
      application_fee: application_fee,
      description: charge_description)
  end

  def amount_donated_to_challenge(challenge_id) do
    Dennis.Repo.one from donation in Dennis.Donation,
    where: donation.challenge_id == ^challenge_id,
    select: sum(donation.total_donated)
  end

end
