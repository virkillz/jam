defmodule Jamjaman.ContentTest do
  use Jamjaman.DataCase

  alias Jamjaman.Content

  describe "project" do
    alias Jamjaman.Content.Project

    @valid_attrs %{approval_time: ~N[2010-04-17 14:00:00.000000], description: "some description", is_approved: true, is_ofr: true, status: "some status", title: "some title"}
    @update_attrs %{approval_time: ~N[2011-05-18 15:01:01.000000], description: "some updated description", is_approved: false, is_ofr: false, status: "some updated status", title: "some updated title"}
    @invalid_attrs %{approval_time: nil, description: nil, is_approved: nil, is_ofr: nil, status: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_project()

      project
    end

    test "list_project/0 returns all project" do
      project = project_fixture()
      assert Content.list_project() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Content.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Content.create_project(@valid_attrs)
      assert project.approval_time == ~N[2010-04-17 14:00:00.000000]
      assert project.description == "some description"
      assert project.is_approved == true
      assert project.is_ofr == true
      assert project.status == "some status"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Content.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.approval_time == ~N[2011-05-18 15:01:01.000000]
      assert project.description == "some updated description"
      assert project.is_approved == false
      assert project.is_ofr == false
      assert project.status == "some updated status"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_project(project, @invalid_attrs)
      assert project == Content.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Content.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Content.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Content.change_project(project)
    end
  end
end
