defmodule Placebooru.Thumbnailer do
  @moduledoc """
  Executes thumbnail creation periodically.
  """

  use GenServer

  @timeout 60_000

  def start_link(opts \\ []) do
    GenServer.start_link __MODULE__, [], opts
  end

  ##############################################################################
  # Server callbacks
  def init(_args) do
    {:ok, "", @timeout}
  end

  def handle_info(:timeout, state) do
    generate_thumbnails()
    {:noreply, state, @timeout}
  end

  def generate_thumbnails do
    # TODO: this runs in docker container, not outside...
    imgs = File.ls!("/kyon/data/img")
    thumbs = File.ls!("/kyon/data/thumb")
    imgs -- thumbs
    #|> Script.display
    |> Enum.each(fn file ->
      System.cmd "mogrify", [
        "-resize", "200x200^",
        "-write", "/kyon/data/thumb/#{file}",
        "/kyon/data/img/#{file}[0]"
      ]
    end)
  end

end
