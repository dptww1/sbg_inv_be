defmodule SbgInv.Repo.Migrations.AddUnaccentPostgresModules do
  use Ecto.Migration

  def change do
    execute(
      "CREATE EXTENSION IF NOT EXISTS unaccent;",
      "DROP EXTENSION IF EXISTS unaccent;"
    )

    execute(
        """
        CREATE OR REPLACE FUNCTION f_unaccent(text)
            RETURNS text
            LANGUAGE sql IMMUTABLE PARALLEL SAFE AS
          $func$
            SELECT public.unaccent('public.unaccent', $1)
          $func$;
        """,
        "DROP FUNCTION IF EXISTS f_unaccent(text);"
      )

      execute(
        "CREATE EXTENSION IF NOT EXISTS pg_trgm;",
        "DROP EXTENSION IF EXISTS pg_trgm;"
      )

      execute(
        """
        CREATE INDEX figures_name_unaccented_gin_trgm_idx
          ON figures
          USING gin (f_unaccent(name) gin_trgm_ops)
        """,
        "DROP INDEX IF EXISTS figures_name_unaccented_gin_trgm_idx;"
      )

      execute(
        """
        CREATE INDEX scenarios_name_unaccented_gin_trgm_idx
          ON scenarios
          USING gin (f_unaccent(name) gin_trgm_ops)
        """,
        "DROP INDEX IF EXISTS scenarios_name_unaccented_gin_trgm_idx;"
      )

      execute(
        """
        CREATE INDEX characters_name_unaccented_gin_trgm_idx
          ON characters
          USING gin (f_unaccent(name) gin_trgm_ops)
        """,
        "DROP INDEX IF EXISTS characters_name_unaccented_gin_trgm_idx;"
      )
  end
end
