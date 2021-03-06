defmodule SbgInv do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: SbgInv.Web.PubSub},
      # Start the endpoint when the application starts
      SbgInv.Web.Endpoint,
      # Start the Ecto repository
      SbgInv.Repo,
      # Here you could define other workers and supervisors as children
      # worker(SbgInv.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SbgInv.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
