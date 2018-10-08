defmodule ExCwmanageApiHttpTest do
  use ExUnit.Case
  doctest ExCwmanage

  alias ExCwmanage.Api.HTTPClient, as: HTTPClient

  test "http /get test" do
    {:ok, resp} = HTTPClient.get("/get", [:conditions, "key=value"])
    assert is_map(resp)
    assert Map.has_key?(resp, "args")
  end

  test "http get 404 error" do
    {:error, _err} = HTTPClient.get("/status/404", [])
  end

  test "http /post test" do
    {:ok, resp} = HTTPClient.post("/post", ["this is data"])
    assert is_map(resp)
    assert Map.has_key?(resp, "data")
    assert resp["data"] == "this is data"
  end

  test "http post 404 error" do
    {:error, _err} = HTTPClient.post("/status/404", [])
  end

  test "http /put test" do
    {:ok, resp} = HTTPClient.put("/put", ["this is data"])
    assert is_map(resp)
    assert Map.has_key?(resp, "data")
    assert resp["data"] == "this is data"
  end

  test "http put 404 error" do
    {:error, _err} = HTTPClient.put("/status/404", [])
  end

  test "http /patch test" do
    {:ok, resp} = HTTPClient.patch("/patch", ["this is data"])
    assert is_map(resp)
    assert Map.has_key?(resp, "data")
    assert resp["data"] == "this is data"
  end

  test "http patch 404 error" do
    {:error, _err} = HTTPClient.patch("/status/404", [])
  end

  test "http /delete test" do
    {:ok, resp} = HTTPClient.delete("/delete", [:conditions, "key=value"])
    assert is_map(resp)
    assert Map.has_key?(resp, "args")
  end

  test "http delete 404 error" do
    {:error, _err} = HTTPClient.delete("/status/404", [])
  end

end
