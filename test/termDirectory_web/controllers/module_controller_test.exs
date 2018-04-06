defmodule TermDirectoryWeb.ModuleControllerTest do
  use TermDirectoryWeb.ConnCase

  alias TermDirectory.Modules
  alias TermDirectory.Modules.Module

  @create_attrs %{responsible_teacher: 42, shortName: "some shortName", subject: "some subject"}
  @update_attrs %{responsible_teacher: 43, shortName: "some updated shortName", subject: "some updated subject"}
  @invalid_attrs %{responsible_teacher: nil, shortName: nil, subject: nil}

  def fixture(:module) do
    {:ok, module} = Modules.create_module(@create_attrs)
    module
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all modules", %{conn: conn} do
      conn = get conn, module_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create module" do
    test "renders module when data is valid", %{conn: conn} do
      conn = post conn, module_path(conn, :create), module: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, module_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "teacher_id" => 42,
        "shortName" => "some shortName",
        "subject" => "some subject"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, module_path(conn, :create), module: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update module" do
    setup [:create_module]

    test "renders module when data is valid", %{conn: conn, module: %Module{id: id} = module} do
      conn = put conn, module_path(conn, :update, module), module: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, module_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "teacher_id" => 43,
        "shortName" => "some updated shortName",
        "subject" => "some updated subject"}
    end

    test "renders errors when data is invalid", %{conn: conn, module: module} do
      conn = put conn, module_path(conn, :update, module), module: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete module" do
    setup [:create_module]

    test "deletes chosen module", %{conn: conn, module: module} do
      conn = delete conn, module_path(conn, :delete, module)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, module_path(conn, :show, module)
      end
    end
  end

  defp create_module(_) do
    module = fixture(:module)
    {:ok, module: module}
  end
end
