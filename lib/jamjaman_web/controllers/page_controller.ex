defmodule JamjamanWeb.PageController do
  use JamjamanWeb, :controller

  alias Jamjaman.Account
  alias Jamjaman.Account.User
  alias Jamjaman.User.Guardian

  def index(conn, _params) do
    conn
    |> IO.inspect
    |> render("index.html", layout: {JamjamanWeb.LayoutView, "fe.html"})
  end

  def login(conn, _params) do
  	changeset = Account.change_user(%User{})
    render(conn, "login.html", layout: {JamjamanWeb.LayoutView, "fe.html"}, changeset: changeset)
  end

  def dashboard(conn, _params) do
    user = conn.private.guardian_default_resource
    render(conn, "dashboard.html", layout: {JamjamanWeb.LayoutView, "fedashboard.html"}, user: user)
  end

  def lgn(conn, _params) do
  	changeset = Account.change_user(%User{})
    render(conn, "login-nosocial.html", layout: {JamjamanWeb.LayoutView, "fe.html"}, changeset: changeset)
  end

  def register(conn, _params) do
  	changeset = Account.change_user(%User{})
    render(conn, "register.html", layout: {JamjamanWeb.LayoutView, "fe.html"}, changeset: changeset)
  end

  def createuser(conn, %{"user" => params}) do
  	changeset = Account.change_user(%User{})
    case Account.create_user_frontend(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully. You can login now")
        |> redirect(to: "/lgn")
      {:error, %Ecto.Changeset{} = changeset} ->
      	IO.inspect(changeset)
      	conn
      	|> put_flash(:error, "Oops, check error below")
        |> render("register.html", layout: {JamjamanWeb.LayoutView, "fe.html"}, changeset: changeset)
    end
  end



  def auth(conn, %{"email" => email, "password" => password}) do
  case Account.authenticate_user_front(email, password) do
    {:ok, user} ->
      conn
      |> put_session(:current_user_id, user.id)
      |> Guardian.login(user)
      |> redirect(to: page_path(conn, :dashboard))
    {:error, reason} ->
      changeset = Account.change_user(%User{})
      conn
      |> put_flash(:error, reason)
      |> render("login-nosocial.html", layout: {JamjamanWeb.LayoutView, "fe.html"}, changeset: changeset)
    end
  end


  def createuser(conn, params) do
	IO.inspect(params)
	text(conn, "mbel")  	
  end

  def recover(conn, _params) do
    render(conn, "recover.html", layout: {JamjamanWeb.LayoutView, "fe.html"})
  end  

  def signout(conn, _parms) do
    conn
    # |> Plug.Conn.configure_session(drop: true)
    |> Plug.Conn.clear_session
    |> Guardian.logout()
    |> IO.inspect
    |> redirect(to: "/")
    # |> text("mbel")
  end

  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User, user_id)
  end

  def user_signed_in?(conn) do
    !!current_user(conn)
  end

end
