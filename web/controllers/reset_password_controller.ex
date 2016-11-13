defmodule SbgInv.ResetPasswordController do
  use SbgInv.Web, :controller

  alias SbgInv.{Email, Mailer, User}

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: Map.get(user_params, "email"))
    new_password = random_string(12)
    if user do
      changeset = User.registration_changeset(user, %{"password" => new_password})
      case Repo.update(changeset) do
        {:ok, _} ->
          Email.forgot_password_email(Map.get(user_params, "email"), new_password) |> Mailer.deliver_later
          send_resp(conn, :no_content, "")

        {:error, _} ->
          send_resp(conn, :internal_server_error, "")
      end
    else
      send_resp(conn, :not_found, "")
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
