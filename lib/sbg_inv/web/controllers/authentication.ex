defmodule SbgInv.Web.Authentication do
  use Plug.Builder

  import Plug.Conn
  import Ecto.Query, only: [from: 2]

  alias SbgInv.Repo
  alias SbgInv.Web.{Session, User}

  @doc """
  Returns the id of the currently authenticated user, or -1
  if the user is not authenticated.
  """
  def user_id(conn) do
    extract_user_id(conn.assigns[:current_user])
  end

  defp extract_user_id(%User{id: id}), do: id
  defp extract_user_id(nil), do: -1

  # Required Plug module method
  def call(conn, opts) do
    # Need to call Plug.Builder's implementation so plug chaining works
    conn = super(conn, opts)

    validate_auth_header(conn, get_req_header(conn, "authorization"))
  end

  defp validate_auth_header(conn, []), do: conn
  defp validate_auth_header(conn, val) do
    with val,
         {:ok, token}   <- parse_token(val),
         {:ok, session} <- find_session_by_token(token),
         {:ok, user}    <- find_user_by_session(session)
    do
      assign(conn, :current_user, user)
    else
      _ -> auth_error!(conn)
    end
  end

  defp parse_token(["Token token=" <> token]) do
    {:ok, String.replace(token, "\"", "")}
  end
  defp parse_token(_non_token_header), do: :no_token

  defp find_session_by_token(token) do
    case Repo.one(from s in Session, where: s.token == ^token) do
      nil     -> :error
      session -> {:ok, session}
    end
  end

  defp find_user_by_session(session) do
    case Repo.get(User, session.user_id) do
      nil  -> :error
      user -> {:ok, user}
    end
  end

  defp auth_error!(conn) do
    conn
    |> put_status(:unauthorized)
    |> halt
  end
end
