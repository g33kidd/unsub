ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Unsub.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Unsub.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Unsub.Repo)

