defmodule Placebooru.Router do
  use Placebooru.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
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
    get "/item/upload", ItemController, :preupload
    post "/item/upload", ItemController, :upload

    get "/activity/comments/:page", ActivityController, :comments
    get "/activity/tags/:page", ActivityController, :tags
    get "/activity/favs/:page", ActivityController, :favs_all
    get "/activity/favs/:user_id/:page", ActivityController, :favs

    # user login/logout/registration -> use trenpixster/addict (remove mails)
  end

   scope "/api", Placebooru do
     pipe_through :api
     get "/api/find_tags", TagController, :list
     post "/api/add_post", ItemController, :upload
   end

end
