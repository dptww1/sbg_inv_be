defmodule SbgInv.Web.CharacterController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.{Authentication, Character}

  def show(conn, %{"id" => id}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")
    end

    with {:ok, char} <- load_character(id)
    do
      render(conn, "character.json", character: char)
    else
      _ -> send_resp(conn, :unprocessable_entity, "")
    end
  end

  def create(conn, %{"character" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      update_or_create(conn, %Character{}, params)
    end
  end

  def update(conn, %{"id" => id, "character" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
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
    char = Repo.get(Character, id) |> Repo.preload(:figures)
    if char do
      {:ok, char}
    else
      {:error}
    end
  end
end
