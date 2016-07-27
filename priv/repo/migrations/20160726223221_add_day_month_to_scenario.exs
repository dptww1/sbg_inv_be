defmodule SbgInv.Repo.Migrations.AddDayMonthToScenario do
  use Ecto.Migration

  def change do
    alter table(:scenarios) do
      add :date_month, :integer   # 1-12; 0=unknown
      add :date_day,   :integer   # 1-31; 0=unknown
    end
  end
end
