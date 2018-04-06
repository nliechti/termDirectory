defmodule TermDirectory.ModulesTest do
  use TermDirectory.DataCase

  alias TermDirectory.Modules

  describe "modules" do
    alias TermDirectory.Modules.Module

    @valid_attrs %{teacher_id: 42, shortName: "some shortName", subject: "some subject"}
    @update_attrs %{teacher_id: 43, shortName: "some updated shortName", subject: "some updated subject"}
    @invalid_attrs %{teacher_id: nil, shortName: nil, subject: nil}

    def module_fixture(attrs \\ %{}) do
      {:ok, module} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Modules.create_module()

      module
    end

    test "list_modules/0 returns all modules" do
      module = module_fixture()
      assert Modules.list_modules() == [module]
    end

    test "get_module!/1 returns the module with given id" do
      module = module_fixture()
      assert Modules.get_module!(module.id) == module
    end

    test "create_module/1 with valid data creates a module" do
      assert {:ok, %Module{} = module} = Modules.create_module(@valid_attrs)
      assert module.teacher_id == 42
      assert module.shortName == "some shortName"
      assert module.subject == "some subject"
    end

    test "create_module/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Modules.create_module(@invalid_attrs)
    end

    test "update_module/2 with valid data updates the module" do
      module = module_fixture()
      assert {:ok, module} = Modules.update_module(module, @update_attrs)
      assert %Module{} = module
      assert module.teacher_id == 43
      assert module.shortName == "some updated shortName"
      assert module.subject == "some updated subject"
    end

    test "update_module/2 with invalid data returns error changeset" do
      module = module_fixture()
      assert {:error, %Ecto.Changeset{}} = Modules.update_module(module, @invalid_attrs)
      assert module == Modules.get_module!(module.id)
    end

    test "delete_module/1 deletes the module" do
      module = module_fixture()
      assert {:ok, %Module{}} = Modules.delete_module(module)
      assert_raise Ecto.NoResultsError, fn -> Modules.get_module!(module.id) end
    end

    test "change_module/1 returns a module changeset" do
      module = module_fixture()
      assert %Ecto.Changeset{} = Modules.change_module(module)
    end
  end
end
