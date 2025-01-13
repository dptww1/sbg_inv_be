defmodule SbgInv.Web.AboutController do
  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.About

  def index(conn, _params) do
    about = About.query_singleton() |> Repo.one!

    render(conn, "index.json", about: about)
  end

  # as About is effectively a singleton, the "id" parameter can be ignored
  def update(conn, %{"about" => about_params}) do
    with_admin_user conn do
      about = About.query_singleton() |> Repo.one!

      changeset = About.changeset(about, about_params)

      case Repo.insert_or_update(changeset) do
        {:ok, _about} ->
          send_resp(conn, :no_content, "")

        {:error, _changeset} ->
          send_resp(conn, :unprocessable_entity, "")
      end
    end
  end
end
