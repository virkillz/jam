defmodule JamjamanWeb.ProjectController do
  use JamjamanWeb, :controller

  alias Jamjaman.Content
  alias Jamjaman.Content.Project

  def index(conn, _params) do
    project = Content.list_project()
    render(conn, "index.html", project: project)
  end

  def feindex(conn, _params) do
    # project = Content.list_project()
    user = conn.private.guardian_default_resource
    render(conn, "feindex.html", layout: {JamjamanWeb.LayoutView, "fedashboard.html"}, user: user)    
  end

  def new(conn, _params) do
    changeset = Content.change_project(%Project{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project_params}) do
    case Content.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Content.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Content.get_project!(id)
    changeset = Content.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Content.get_project!(id)

    case Content.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Content.get_project!(id)
    {:ok, _project} = Content.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: project_path(conn, :index))
  end
end
