defmodule ExCwmanageApiHttpTest do
  use ExUnit.Case
  doctest ExCwmanage

  alias ExCwmanage.Api.HTTPClient, as: HTTPClient

  describe "get_http/1 and get_http/2" do
    test "http /get test" do
      {:ok, resp} = HTTPClient.get_http("/get")
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
    end
    test "http /get test with conditions" do
      {:ok, resp} = HTTPClient.get_http("/get", [conditions: "key=value"])
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
      assert Map.fetch!(resp, "args") == %{"conditions" => "key=value"}
    end
    test "http get 404 error" do
      {:ok, resp} = HTTPClient.get("/status/404", [])
      assert resp.status == 404
    end
  end

  describe "post_http/1 and post_http/2" do
    test "http /post test" do
      {:ok, resp} = HTTPClient.post_http("/post", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") |> Poison.decode! == ["this is data"]
    end
    test "http post 404 error" do
      {:ok, resp} = HTTPClient.post("/status/404", [])
      assert resp.status == 404
    end
  end

  describe "put_http/1 and put_http/2" do
    test "http /put test" do
      {:ok, resp} = HTTPClient.put_http("/put", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") |> Poison.decode! == ["this is data"]
    end
    test "http put 404 error" do
      {:ok, resp} = HTTPClient.put("/status/404", [])
      assert resp.status == 404
    end
  end

  describe "patch_http/1 and patch_http/2" do
    test "http /patch test" do
      {:ok, resp} = HTTPClient.patch_http("/patch", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") |> Poison.decode! == ["this is data"]
    end
    test "http patch 404 error" do
      {:ok, resp} = HTTPClient.patch("/status/404", [])
      assert resp.status == 404
    end
  end

  describe "delete_http/1 and delete_http/2" do
    test "http /delete test" do
      {:ok, resp} = HTTPClient.delete_http("/delete")
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
    end
    test "http /delete test with conditions" do
      {:ok, resp} = HTTPClient.delete_http("/delete", [conditions: "key=value"])
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
      assert Map.fetch!(resp, "args") == %{"conditions" => "key=value"}
    end
    test "http delete 404 error" do
      {:ok, resp} = HTTPClient.delete("/status/404", [])
      assert resp.status == 404
    end
  end

end
