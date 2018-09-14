defmodule JamjamanWeb.Router do
  use JamjamanWeb, :router

  # -----------------pipeline ----------------

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug JamjamanWeb.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug(Jamjaman.Auth.AuthAccessPipeline)
  end

  pipeline :user do
    plug(Jamjaman.User.AuthAccessPipeline)
  end

  # ----------------- scope route ----------------


  scope "/admin", JamjamanWeb do
    pipe_through([:browser,:auth]) # Use the default browser stack

    get "/", UserController, :dashboard
    get "/profile", UserController, :profile
    get "/locked", UserController, :locked
    resources "/activity", ActivityController, only: [:index, :show, :delete]
    resources "/user", UserController
    resources "/category", CategoryController
    resources "/project", ProjectController

    get "/logout", UserController, :logout 
  end


  scope "/", JamjamanWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :login
    get "/lgn", PageController, :lgn    
    get "/register", PageController, :register
    post "/login", PageController, :auth
    post "/register", PageController, :createuser 
    get "/recover", PageController, :recover        
    get "/admin/login", UserController, :login
    post "/admin/login", UserController, :auth  
    get "/signout", PageController, :signout 

  end

  scope "/dashboard", JamjamanWeb do
    pipe_through [:browser, :user]

    get "/", PageController, :dashboard
    get "/project/create", ProjectController, :fecreate 
    get "/project/", ProjectController, :feindex      
  end


  # Other scopes may use custom stacks.
  # scope "/api", JamjamanWeb do
  #   pipe_through :api
  # end
end
