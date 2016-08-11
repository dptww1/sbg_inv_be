defmodule SbgInv.RecalcControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.Recalc
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, recalc_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    recalc = Repo.insert! %Recalc{}
    conn = get conn, recalc_path(conn, :show, recalc)
    assert json_response(conn, 200)["data"] == %{"id" => recalc.id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, recalc_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, recalc_path(conn, :create), recalc: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Recalc, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, recalc_path(conn, :create), recalc: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    recalc = Repo.insert! %Recalc{}
    conn = put conn, recalc_path(conn, :update, recalc), recalc: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Recalc, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    recalc = Repo.insert! %Recalc{}
    conn = put conn, recalc_path(conn, :update, recalc), recalc: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    recalc = Repo.insert! %Recalc{}
    conn = delete conn, recalc_path(conn, :delete, recalc)
    assert response(conn, 204)
    refute Repo.get(Recalc, recalc.id)
  end
end
