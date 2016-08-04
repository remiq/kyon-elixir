defmodule Placebooru.Mixfile do
  use Mix.Project

  def project do
    [app: :placebooru,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Placebooru, []},
     applications: [
       :phoenix, :phoenix_html, :phoenix_pubsub,
       :logger,
       :phoenix_ecto, :postgrex, :httpoison,
       :html_sanitize_ex, :slack_webhook, :earmark, :porcelain, :comeonin,
       :earmark,
       :cowboy]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  def aliases, do: [
    backup: &backup/1,
    brunch: &brunch/1,
    r: ["compile", "brunch", "phoenix.digest", "release", "backup"]
  ]

  defp brunch(_args) do
    {stdout, _status} = System.cmd("brunch", ["b"])
    IO.puts stdout
  end

  defp backup(_args) do
    conf = project()
    app_name = Atom.to_string(conf[:app])
    version = conf[:version]
    System.cmd("cp", ["rel/#{app_name}/releases/#{version}/#{app_name}.tar.gz", "../backup/app/#{version}.tar.gz"])
    System.cmd("cp", ["../backup/app/#{version}.tar.gz", "../backup/app/latest.tar.gz"])
  end


  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, "~> 0.11.2"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:comeonin, "~> 2.5"},
     {:httpoison, "~> 0.9.0"},
     {:html_sanitize_ex, "~> 1.0"},
     {:earmark, "~> 1.0"},
     {:slack_webhook, "~> 0.1.0"},
     {:exrm, "~> 1.0"},
     {:porcelain, "~>  2.0"},
     {:cowboy, "~> 1.0.2"}]
  end
end
