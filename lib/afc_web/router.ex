defmodule AfcWeb.Router do
  use AfcWeb, :router
  import AfcWeb.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AfcWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AfcWeb do
    pipe_through :browser # Use the default browser stack

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", AfcWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/emotion", EmotionController, only: [:show, :create]
    resources "/info", InfoController, only: [:show]
    get "/log", LogController, :index
    get "/weekly-log", WeeklyLogController, :index
    get "/monthly-log", MonthlyLogController, :index
    resources "/share", ShareController, only: [:create]
    resources "/share/report", ShareReportController, only: [:create]
    resources "/", PageController, only: [:index, :show]
  end
end
