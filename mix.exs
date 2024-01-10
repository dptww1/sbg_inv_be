defmodule SbgInv.Mixfile do
  use Mix.Project

  def project do
    [app: :sbg_inv,
     version: "0.0.1",
     elixir: "1.14.5",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
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
    [{:phoenix, "~> 1.5.9"},
     {:phoenix_pubsub, "~> 2.0" },
     {:postgrex, ">= 0.0.0"},
     {:ecto_sql, "~> 3.0"},
     {:phoenix_ecto, "~> 4.3"},
     {:phoenix_html, "~> 2.14.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:pathex, "~> 2.0"},
     {:plug_cowboy, "~> 2.1"},
     {:plug, "~> 1.7"},
     {:corsica, "~> 0.4"},
     {:jason, "~> 1.0"},
     {:ecto_enum, "~> 1.4"},
     {:pbkdf2_elixir, "~> 1.4"},
     {:secure_random, "~> 0.2"},
     {:bamboo, "~> 2.1.0"},
     {:bamboo_smtp, "~> 4.0.1"},
     {:distillery, "~> 2.1.1"}
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
