defmodule Placebooru.Endpoint do
  use Phoenix.Endpoint, otp_app: :placebooru

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :placebooru, gzip: false,
    only: ~w(css images items js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  conf = Application.get_env(:placebooru, Placebooru.Endpoint)

  plug Plug.Session,
    store: :cookie,
    key: "_placebooru_key",
    signing_salt: Dict.get(conf, :session_signing_salt, "")

  plug Placebooru.Router
end
