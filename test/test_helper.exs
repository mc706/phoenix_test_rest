ExUnit.start

Mix.Task.run "ecto.create", ~w(-r TestRest.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r TestRest.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(TestRest.Repo)

