defmodule AfcWeb.Router do
  use AfcWeb, :router

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

  scope "/", AfcWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/emotion", EmotionController, only: [:show, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", AfcWeb do
  #   pipe_through :api
  # end
end
