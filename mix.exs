defmodule Dennis.Mixfile do
  use Mix.Project

  def project do
    [app: :dennis,
     version: "1.0.0",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Dennis, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, :httpoison, :erlcloud,
                    :arc, :arc_ecto, :jazz, :meck, 
                    :ex_doc,:comeonin, :mailgun, :logger_file_backend,
                    :mock, :commerce_billing]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.0"},
     {:phoenix_ecto, "~> 1.1"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.1"},
     {:phoenix_live_reload, "~> 1.0"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 1.0"},
     {:httpoison, "~> 0.7.2"},
     {:commerce_billing, git: "https://github.com/joshnuss/commerce_billing"},
     {:mailgun, "~> 0.1.1"},
     {:arc, "~> 0.1.3"},
     {:arc_ecto, "~> 0.2.0"},
     {:exrm, "~> 1.0.0-rc7"},
     {:logger_file_backend, "~> 0.0.6"}]
  end
end
