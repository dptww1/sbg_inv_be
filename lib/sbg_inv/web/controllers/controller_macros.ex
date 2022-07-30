defmodule SbgInv.Web.ControllerMacros do

  @doc """
  Executes the given block if:
  - the `conn` isn't halted
  - the `conn` has a current user (as supplied by the SbgInv.Web.Authentication module)
  - that current user is an administrator

  Otherwise, halts the conn.
  """
  defmacro with_admin_user(conn, do: block) do
    quote do
      if (unquote(conn).halted)
         || !Map.get(unquote(conn).assigns, :current_user)
         || !Map.get(unquote(conn).assigns, :current_user).is_admin do
        unquote(conn)
        |> put_status(:unauthorized)
        |> halt
      else
        unquote(block)
      end
    end
  end

  @doc """
  Executes the given block if:
  - the `conn` isn't halted
  - the `conn` has a current user (as supplied by the SbgInv.Web.Authentication module)

  Otherwise, halts the conn.
  """
  defmacro with_auth_user(conn, do: block) do
    quote do
      if (unquote(conn).halted)
         || !Map.get(unquote(conn).assigns, :current_user) do
        unquote(conn)
        |> put_status(:unauthorized)
        |> halt
      else
        unquote(block)
      end
    end
  end
end
