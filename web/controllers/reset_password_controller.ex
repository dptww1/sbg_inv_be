defmodule SbgInv.ResetPasswordController do
  use SbgInv.Web, :controller

  alias SbgInv.User

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: Map.get(user_params, "email"))
    if user do
      changeset = User.registration_changeset(user, %{"password" => random_string(12)})
      case Repo.update(changeset) do
        {:ok, _}    -> put_status(conn, :no_content)
        {:error, _} -> put_status(conn, :internal_server_error)
      end
    else
      put_status(conn, :not_found)
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
