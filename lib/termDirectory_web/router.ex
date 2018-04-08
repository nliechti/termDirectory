defmodule TermDirectoryWeb.Router do
  use TermDirectoryWeb, :router

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

#  scope "/", TermDirectoryWeb do
#    pipe_through :browser # Use the default browser stack
#
#    get "/", PageController, :index
#  end
  
  scope "/api/v1", TermDirectoryWeb do
    pipe_through :api
    resources "/teachers", TeacherController
    resources "/modules", ModuleController
    resources "/facts", FactController
    resources "/factTypes", FactTypeController
  end
end
