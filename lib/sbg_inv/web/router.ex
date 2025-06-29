defmodule SbgInv.Web.Router do
  use SbgInv.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :dynamic_js do
    plug :accepts, ["javascript"]
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug SbgInv.Web.Authentication
  end

  scope "/", SbgInv.Web do
    pipe_through :dynamic_js

    resources "/js", JavascriptController, only: [:show]
  end

  scope "/api", SbgInv.Web do
    pipe_through :api

    resources "/about",            AboutController,         only: [:index, :update]
    resources "/character",        CharacterController,     only: [:create, :show, :update]
    resources "/faction",          FactionController,       only: [:index, :show, :create, :update]
    resources "/figure",           FigureController,        only: [:create, :show, :update]
    resources "/newsitem",         NewsItemController,      only: [:create, :index, :update, :delete]
    resources "/recalc",           RecalcController,        only: [:index]
    resources "/reset-password",   ResetPasswordController, only: [:create]
    resources "/search",           SearchController,        only: [:index]
    resources "/scenario-faction", ScenarioFactionController, only: [:update]
    resources "/scenarios",        ScenarioController,      except: [:new, :edit] do
      resources "/resource",       ScenarioResourceController, only: [:index, :create, :update]
    end
    resources "/sessions",         SessionController,       only: [:create]
    resources "/stats",            StatsController,         only: [:index]
    resources "/userfigure",       UserFigureController,    only: [:create]
    resources "/userhistory",      UserHistoryController,   only: [:delete, :index, :update]
    resources "/userscenarios",    UserScenarioController,  only: [:create]
    resources "/users",            UserController,          only: [:create, :update]
  end
end
