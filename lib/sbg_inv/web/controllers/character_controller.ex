defmodule SbgInv.Web.CharacterController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{Character}

  def show(conn, %{"id" => id}) do
    with_admin_user conn do
      with {:ok, char} <- load_character(id)
      do
        render(conn, "character.json", character: char)
      else
        _ -> send_resp(conn, :unprocessable_entity, "")
      end
    end
  end

  def create(conn, %{"character" => params}) do
    with_admin_user conn do
      update_or_create(conn, %Character{}, params)
    end
  end

  def update(conn, %{"id" => id, "character" => params}) do
    with_admin_user conn do
      {:ok, char} = load_character(id)
      update_or_create(conn, char, params)
    end
  end

  defp update_or_create(conn, nil, _), do: send_resp(conn, :unprocessable_entity, "")
  defp update_or_create(conn, char, params) do
    success_status = if char.id, do: :ok, else: :created

    with {:ok, char} <- Repo.insert_or_update(Character.changeset(char, params)),
         {:ok, char} <- load_character(char.id)
    do
      conn
      |> put_status(success_status)
      |> render("character.json", character: char)
    else
      _ -> send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp load_character(id) do
    char =
      Character.query_by_id(id)
      |> Character.with_figures
      |> Character.with_resources
      |> Character.with_rules
      |> Repo.one

    if char do
      {:ok, char}
    else
      {:error}
    end
  end
end
