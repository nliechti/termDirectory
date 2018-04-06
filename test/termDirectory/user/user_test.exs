defmodule TermDirectory.UserTest do
  use TermDirectory.DataCase

  alias TermDirectory.User

  describe "teachers" do
    alias TermDirectory.User.Teacher

    @valid_attrs %{firstName: "some firstName", lastName: "LastName"}
    @update_attrs %{firstName: "some updated firstName", lastName: "Updated LastName"}
    @invalid_attrs %{firstName: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert User.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert User.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = User.create_teacher(@valid_attrs)
      assert teacher.firstName == "some firstName"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, teacher} = User.update_teacher(teacher, @update_attrs)
      assert %Teacher{} = teacher
      assert teacher.firstName == "some updated firstName"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_teacher(teacher, @invalid_attrs)
      assert teacher == User.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = User.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> User.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = User.change_teacher(teacher)
    end
  end
end
