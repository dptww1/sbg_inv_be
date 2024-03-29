defmodule SbgInv.Web.UserController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{User}

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(SbgInv.Web.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with_auth_user conn do
      user =
        User.query_by_id(id)
        |> Repo.one

      changeset = cond do
        is_nil(Map.get user_params, "email")
          -> User.update_password_changeset(user, user_params)

        is_nil(Map.get user_params, "password")
          -> User.update_email_changeset(user, user_params)

        true
          -> User.update_changeset(user, user_params)
      end

      case Repo.update(changeset) do
        {:ok, user} -> render(conn, "show.json", user: user)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> put_view(SbgInv.Web.ChangesetView)
          |> render("error.json", changeset: changeset)
      end
    end
  end
end
