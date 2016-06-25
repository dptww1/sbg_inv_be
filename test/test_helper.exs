ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SbgInv.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SbgInv.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SbgInv.Repo)

