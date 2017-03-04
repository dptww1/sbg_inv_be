defmodule SbgInv.Web.PageController do

  use SbgInv.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
