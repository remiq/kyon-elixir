use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :placebooru, Placebooru.Endpoint,
  http: [port: System.get_env("PORT")],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :placebooru, Placebooru.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :placebooru, Placebooru.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("POSTGRES_HOST"),
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: System.get_env("POSTGRES_USER"),
  pool_size: 10 # The amount of database connections in the pool

config :placebooru, :branding, %{
  title: "DEV kyon.pl",
  file_prefix: "kyon.pl_",
  main_page: """
  Kyon.pl is back. Why? I'm not sure.

  Oh, I have open-sourced it. You can check it [here](https://github.com/remiq/kyon-elixir).

  --

  remiq, 15 may 2015
  """
}

config :slack_webhook, :url, System.get_env("SLACK_WEBHOOK")

