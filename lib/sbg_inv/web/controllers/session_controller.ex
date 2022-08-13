defmodule SbgInv.Web.SessionController do

  use SbgInv.Web, :controller

  import Pbkdf2, only: [verify_pass: 2, no_user_verify: 0]

  alias SbgInv.Web.{Session, User}

  def create(conn, %{"user" => user_params}) do
    user = Repo.one(User.query_by_email(user_params["email"]))
    cond do
      user && verify_pass(user_params["password"], user.password_hash) ->
        session_changeset = Session.registration_changeset(%Session{}, %{user_id: user.id})
        {:ok, session} = Repo.insert(session_changeset)
        conn
        |> put_status(:created)
        |> render("show.json", session: %{session | user: user})
      user ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
      true ->
        no_user_verify()
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
    end
  end
end
