defmodule SbgInv.Repo.Migrations.SourceIssueTypeChange do
  use Ecto.Migration

  def change do
    alter table(:scenario_resources) do
      modify :issue, :text
    end
  end
end
