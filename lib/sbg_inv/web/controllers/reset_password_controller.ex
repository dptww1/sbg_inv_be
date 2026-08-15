defmodule SbgInv.Web.ResetPasswordController do

  use SbgInv.Web, :controller

  alias SbgInv.Email
  alias SbgInv.Web.User

  def create(conn, %{"user" => user_params}) do
    if Map.get(user_params, "token") do
      reset_password(conn, user_params)
    else
      send_reset_link_email(conn, user_params)
    end
  end

  defp reset_password(conn, params) do
    email = Map.get(params, "email")
    new_password = Map.get(params, "password")
    token = Map.get(params, "token")

    user = User.query_by_email(email)
    |> Repo.one

    if validate_create_params(user, token) do
      changeset = User.update_password_changeset(user, %{
                    "password" => new_password,
                    "reset_token" => nil
                  })

      case Repo.update(changeset) do
        {:ok,    _} -> send_resp(conn, :no_content, "")
        {:error, _} -> send_resp(conn, :internal_server_error, "")
      end
    else
      send_resp(conn, :unauthorized, "{ \"errors\": \"Invalid password reset request\" }")
    end
  end

  defp send_reset_link_email(conn, params) do
    email = Map.get(params, "email")

    user = User.query_by_email(email)
    |> Repo.one

    if user do
      reset_token = random_string(12)
      changeset = User.reset_token_changeset(user, %{"reset_token" => reset_token})

      case Repo.update(changeset) do
        {:ok, _} ->
          Email.forgot_password_email(email, reset_token)
          send_resp(conn, :no_content, "")

        {:error, _} ->
          send_resp(conn, :internal_server_error, "")
      end
    else
      send_resp(conn, :not_found, "{ \"errors\": \"Unknown email address\" }")
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp validate_create_params(user, token) do
    user != nil && user.reset_token == token
  end
end
