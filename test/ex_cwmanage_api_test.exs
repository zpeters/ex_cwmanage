defmodule ExCwmanageApiTest do
  use ExUnit.Case
  doctest ExCwmanage

  alias ExCwmanage.Api, as: Api

  test "test get page default" do
    {:ok, next, resp} = Api.get_page("/company/companies")
    assert next != nil
    assert next > 0
    assert is_map(resp)
  end

  test "test get raw page (no json)" do
    {:ok, resp} = Api.get_raw("/system/info")
    assert is_binary(resp)
  end

  test "test get no conditions" do
    {:ok, resp} = Api.get("/system/info")
    assert is_map(resp)
    assert Map.has_key?(resp, "version")
  end

  test "test bad path" do
    {:error, resp} = Api.get("/badpath")
    assert resp == {:invalid, "<", 0}
  end

  test "get with conditions" do
    {:ok, resp} = Api.get("/service/locations")
    {:ok, resp2} = Api.get("/service/locations", conditions: "id=1")
    assert length(resp) > 0
    assert length(resp2) > 0
    assert length(resp) > length(resp2)
  end

  test "post function returns placeholder :ok" do
    resp = Api.post("/", %{})
    assert resp == :ok
  end

  test "patch function returns placeholder :ok" do
    resp = Api.patch("/", %{})
    assert resp == :ok
  end

  test "put function returns placeholder :ok" do
    resp = Api.put("/", %{})
    assert resp == :ok
  end

  test "delete function returns placeholder :ok" do
    resp = Api.delete("/", [])
    assert resp == :ok
  end
end
