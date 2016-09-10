defmodule SbgInv.Router do
  use SbgInv.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SbgInv do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", SbgInv do
    pipe_through :api

    resources "/scenarios", ScenarioController, except: [:new, :edit]
    resources "/sessions",  SessionController,  only: [:create]
    resources "/recalc",    RecalcController,   only: [:index]
    resources "/users",     UserController,     only: [:create]
  end
end
