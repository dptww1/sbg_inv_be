defmodule SbgInv.Web.CharacterController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{BookUtils, Character}

  def show(conn, %{"id" => id}) do
    with_admin_user conn do
      if char = _load_character(id) do
        render(conn, "character.json", character: char)
      else
        send_resp(conn, :unprocessable_entity, "")
      end
    end
  end

  def create(conn, %{"character" => params}) do
    with_admin_user conn do
      _create_or_update(conn, %Character{}, params)
    end
  end

  def update(conn, %{"id" => id, "character" => params}) do
    with_admin_user conn do
      char = _load_character(id)
      _create_or_update(conn, char, params)
    end
  end

  defp _create_or_update(conn, nil, _), do: send_resp(conn, :unprocessable_entity, "")
  defp _create_or_update(conn, char, params) do
    success_status = if char.id, do: :ok, else: :created

    params = params
    |> Map.put("rules", BookUtils.add_book_refs(params["rules"]))
    |> Map.put("resources", BookUtils.add_book_refs(params["resources"]))

    changeset = Character.changeset(char, params)

    case Repo.insert_or_update(changeset) do
      {:ok, character} ->
        conn = put_status(conn, success_status)
        character = _load_character(character.id)
        render(conn, "character.json", character: character)

      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(SbgInv.Web.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  defp _load_character(id) do
    Character.query_by_id(id)
    |> Character.with_figures
    |> Character.with_resources
    |> Character.with_rules
    |> Repo.one
  end
end
