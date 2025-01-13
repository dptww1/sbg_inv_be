defmodule SbgInv.Web.AboutController do
  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.About

  def index(conn, _params) do
    render(conn, "index.json", about: load_about())
  end

  # as About is effectively a singleton, the "id" parameter can be ignored
  def update(conn, %{"about" => about_params}) do
    with_admin_user conn do
      about = load_about()

      changeset = About.changeset(about, about_params)

      case Repo.insert_or_update(changeset) do
        {:ok, _about} ->
          render(conn, "index.json", about: load_about())

        {:error, _changeset} ->
          send_resp(conn, :unprocessable_entity, "")
      end
    end
  end

  defp load_about do
    About.query_singleton()
    |> About.with_faqs()
    |> Repo.one!
  end
end
