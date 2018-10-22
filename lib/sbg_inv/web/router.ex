defmodule SbgInv.Web.Router do
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

  scope "/api", SbgInv.Web do
    pipe_through :api

    resources "/faction",        FactionController,       only: [:show]
    resources "/figure",         FigureController,        only: [:show]
    resources "/newsitem",       NewsItemController,      only: [:index]
    resources "/recalc",         RecalcController,        only: [:index]
    resources "/reset-password", ResetPasswordController, only: [:create]
    resources "/search",         SearchController,        only: [:index]
    resources "/scenarios",      ScenarioController,      except: [:create, :delete, :update] do
      resources "/resource",     ScenarioResourceController, only: [:create, :update]
    end
    resources "/sessions",       SessionController,       only: [:create]
    resources "/userfigure",     UserFigureController,    only: [:create]
    resources "/userscenarios",  UserScenarioController,  only: [:create]
    resources "/users",          UserController,          only: [:create, :update]
  end
end
