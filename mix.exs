defmodule SbgInv.Mixfile do
  use Mix.Project

  def project do
    [app: :sbg_inv,
     version: "0.0.1",
     elixir: "1.18.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:yecc] ++ Mix.compilers(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
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
    [{:phoenix, "~> 1.7.18"},
     {:phoenix_pubsub, "~> 2.0"},
     {:phoenix_view, "~> 2.0.4"},
     {:postgrex, ">= 0.19.3"},
     {:ecto_sql, "~> 3.12.1"},
     {:phoenix_ecto, "~> 4.6.3"},
     {:phoenix_html, "~> 4.2.0"},
     {:phoenix_html_helpers, "~> 1.0"},
     {:phoenix_live_reload, "~> 1.5.3", only: :dev},
     {:gettext, "~> 0.26.2"},
     {:pathex, "~> 2.6.0"},
     {:plug_cowboy, "~> 2.7.2"},
     {:plug, "~> 1.16.1"},
     {:corsica, "~> 2.1.3"},
     {:jason, "~> 1.4.4"},
     {:ecto_enum, "~> 1.4"},
     {:pbkdf2_elixir, "~> 2.3.0"},
     {:secure_random, "~> 0.2"},
     {:bamboo, "~> 2.2.0"},
     {:bamboo_smtp, "~> 4.1.0"},
     {:ssl_verify_fun, "~> 1.1.6"}
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
