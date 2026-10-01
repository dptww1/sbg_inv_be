defmodule SbgInv.Mixfile do
  use Mix.Project

  def project do
    [app: :sbg_inv,
     version: "0.0.1",
     elixir: "1.20.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:yecc] ++ Mix.compilers(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     listeners: [Phoenix.CodeReloader]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SbgInv, []},
      extra_applications: [:crypto, :eex, :logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.8.9"},
     {:phoenix_pubsub, "~> 2.2.0"},
     {:phoenix_view, "~> 2.0.4"},
     #{:phoenix_live_view, "~> 1.0.2"},
     #{:phoenix_live_dashboard, "~> 0.8.6"},
     {:postgrex, ">= 0.19.3"},
     {:ecto_sql, "~> 3.14.0"},
     {:phoenix_ecto, "~> 4.7.0"},
     {:phoenix_html, "~> 4.3.0"},
     {:phoenix_html_helpers, "~> 1.0"},
     {:phoenix_live_reload, "~> 1.7.0", only: :dev},
     {:gettext, "~> 1.0.2"},                           # https://github.com/elixir-gettext/gettext/blob/main/mix.exs
     {:pathex, "~> 2.6.1"},                            # https://github.com/hissssst/pathex/blob/master/mix.exs
     {:plug_cowboy, "~> 2.9.0"},
     {:plug, "~> 1.20.3"},
     {:req, "~> 0.4"},
     {:corsica, "~> 2.1.3"},                           # https://hex.pm/packages/corsica
     {:jason, "~> 1.4.5"},                             # https://hex.pm/packages/jason
     {:ecto_enum, "~> 1.4"},
     {:pbkdf2_elixir, "~> 2.3.1"},                     # https://github.com/riverrun/pbkdf2_elixir/blob/master/mix.exs
     {:secure_random, "~> 0.5.1"},                     # https://github.com/patricksrobertson/secure_random.ex/blob/master/mix.exs
     {:swoosh, "~> 1.27"},
     {:hackney, "~> 4.7.2"},                           # needed by swoosh
     {:ssl_verify_fun, "~> 1.1.7"}                     # https://github.com/deadtrickster/ssl_verify_fun.erl
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
