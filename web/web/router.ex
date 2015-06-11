defmodule Placebooru.Router do
  use Placebooru.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Placebooru.Authenticate, :anybody
    #plug :protect_from_forgery
  end

  pipeline :members_only do
    plug Placebooru.Authenticate, :registered
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Placebooru do
    pipe_through :browser

    get "/", PageController, :index
    get "/tag/all/:page", TagController, :all
    get "/tag/:id/:page/:name", TagController, :single
    get "/item/:id/:tags", ItemController, :view
    get "/activity/comments/:page", ActivityController, :comments
    get "/activity/tags/:page", ActivityController, :tags
    get "/activity/favs/:page", ActivityController, :favs_all
    get "/activity/favs/:user_id/:page", ActivityController, :favs
    post "/login", UserController, :login
    get "/logout", UserController, :logout
  end

  # Members only
  scope "/", Placebooru do
    pipe_through [:browser, :members_only]

    get "/item/upload", ItemController, :preupload
    post "/item/upload", ItemController, :upload
    post "/tag/:id/comment", TagController, :comment
    post "/item/:id/comment", ItemController, :comment
    post "/item/:id/tag", ItemController, :tag
  end

  scope "/api", Placebooru do
    pipe_through :api
    get "/api/find_tags", TagController, :list
    post "/api/add_post", ItemController, :upload
  end

end
