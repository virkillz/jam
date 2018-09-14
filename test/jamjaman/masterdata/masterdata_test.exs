defmodule Jamjaman.MasterdataTest do
  use Jamjaman.DataCase

  alias Jamjaman.Masterdata

  describe "category" do
    alias Jamjaman.Masterdata.Category

    @valid_attrs %{description: "some description", logo: "some logo", title: "some title"}
    @update_attrs %{description: "some updated description", logo: "some updated logo", title: "some updated title"}
    @invalid_attrs %{description: nil, logo: nil, title: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Masterdata.create_category()

      category
    end

    test "list_category/0 returns all category" do
      category = category_fixture()
      assert Masterdata.list_category() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Masterdata.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Masterdata.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.logo == "some logo"
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Masterdata.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Masterdata.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.description == "some updated description"
      assert category.logo == "some updated logo"
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Masterdata.update_category(category, @invalid_attrs)
      assert category == Masterdata.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Masterdata.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Masterdata.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Masterdata.change_category(category)
    end
  end
end
