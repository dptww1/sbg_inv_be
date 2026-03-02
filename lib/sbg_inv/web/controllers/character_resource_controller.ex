defmodule SbgInv.Web.CharacterResourceController do
  use SbgInv.Web, :controller

  alias SbgInv.Web.CharacterResource

  #import SbgInv.Web.ControllerMacros

  def index(conn, params) do
    limit = Map.get(params, "n", 5)

    resources = CharacterResource.query_recent(limit)
    |> Repo.all

    render(conn, "index.json", resources: resources)
  end
end
