defmodule SbgInv.Web.FigureController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias Ecto.Changeset
  alias SbgInv.Web.{ArmyList, Authentication, Figure}

  def create(conn, %{"figure" => params}) do
    with_admin_user conn do
      create_similar_or_upsert(conn, params, Map.get(params, "same_as"))
    end
  end

  def update(conn, %{"id" => id, "figure" => params}) do
    with_admin_user conn do
      figure = Figure.query_by_id(id)
               |> Figure.with_factions
               |> Repo.one!

      update_or_create(conn, figure, params)
    end
  end

  def show(conn, %{"id" => id}) do
    figure = load_figure(conn, id)
    _show(conn, figure)
  end

  defp _show(conn, nil) do
    put_status(conn, :not_found)
  end
  defp _show(conn, figure) do
    render(conn, "figure.json", %{figure: figure})
  end

  defp create_similar_or_upsert(conn, params, nil), do: update_or_create(conn, %Figure{}, params)
  defp create_similar_or_upsert(conn, params, ""), do: update_or_create(conn, %Figure{}, params)
  defp create_similar_or_upsert(conn, params, same_as) do
    src_figure = Figure.query_by_id(same_as)
                 |> Figure.with_factions
                 |> Figure.with_scenarios
                 |> Figure.with_characters_and_resources_and_rules()
                 |> Repo.one
    create_similar_figure(conn, src_figure, params)
  end

  defp update_or_create(conn, figure, params) do
    ffs = Map.get(params, "factions", [])
    |> Enum.map(&ArmyList.query_by_abbrev/1)
    |> Enum.map(&Repo.one/1)
    |> Enum.map(&(%{:faction_id => &1.id}))
    |> Enum.into([])

    changeset = Figure.changeset(figure, Map.put(params, "faction_figure", ffs))

    case Repo.insert_or_update(changeset) do
      {:ok, figure} ->
        figure = load_figure(conn, figure.id)
        render(conn, "figure.json", figure: figure)

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp create_similar_figure(conn, nil, _) do
    put_status(conn, :not_found)
  end
  defp create_similar_figure(conn, src_figure, params) do
    ffs = Enum.map(src_figure.faction_figure, &(%{faction_id: &1.faction_id}))

    new_figure = %Figure{
      name: Map.get(params, "name"),
      plural_name: Map.get(params, "plural_name"),
      type: src_figure.type,
      unique: src_figure.unique
      #slug: src_figure.slug, # don't copy slug -- that's unique per figure
    }

    changeset = Figure.changeset(new_figure, %{"faction_figure" => ffs})
                |> Changeset.put_assoc(:role, src_figure.role)
                |> Changeset.put_assoc(:characters, src_figure.characters)

    case Repo.insert_or_update(changeset) do
      {:ok, figure}        -> render(conn, "figure.json", figure: load_figure(conn, figure.id))
      {:error, _changeset} -> send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp load_figure(conn, id) do
    user_id = Authentication.user_id(conn)

    Figure.query_by_id(id)
    |> Figure.with_factions
    |> Figure.with_scenarios
    |> Figure.with_user(user_id)
    |> Figure.with_user_history(user_id)
    |> Figure.with_characters_and_resources_and_rules()
    |> Repo.one
  end
end
