defmodule Dennis do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # TODO: move to config.ex ?
    stripe_config = %{
      credentials: {"sk_test_BxsY2JiapXjqgvqxFy9EvVUE", ""},
      default_currency: "USD"
    }    

    children = [
      # Start the endpoint when the application starts
      supervisor(Dennis.Endpoint, []),
      # Start the Ecto repository
      worker(Dennis.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Dennis.Worker, [arg1, arg2, arg3]),
      worker(Commerce.Billing.Worker, [Commerce.Billing.Gateways.Stripe, stripe_config, [name: :stripe]]),
    ]


 

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dennis.Supervisor]
    Supervisor.start_link(children, opts)  
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Dennis.Endpoint.config_change(changed, removed)
    :ok
  end
end
