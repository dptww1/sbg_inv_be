defmodule SbgInv.Web.Endpoint do

  use Phoenix.Endpoint, otp_app: :sbg_inv

  socket "/socket", SbgInv.Web.UserSocket,
      websocket: true,
      longpoll: false

  plug Corsica, origins: "*", allow_headers: ["content-type", "authorization", "accept", "origin"]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :sbg_inv, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_sbg_inv_key",
    signing_salt: "hBU7VwCM"

  plug SbgInv.Web.Router
end
