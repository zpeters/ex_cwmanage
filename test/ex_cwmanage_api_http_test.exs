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
      {:ok, resp} = HTTPClient.get_http("/get", conditions: "key=value")
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
      assert Map.fetch!(resp, "args") == %{"conditions" => "key=value"}
    end

    test "http get 404 error" do
      {:error, resp} = HTTPClient.get_http("/status/404")
      assert resp
    end
  end

  describe "post_http/1 and post_http/2" do
    test "http /post test" do
      {:ok, resp} = HTTPClient.post_http("/post", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") == "this is data"
    end

    test "http post 404 error" do
      {:error, resp} = HTTPClient.post_http("/status/404", [])
      assert resp
    end
  end

  describe "put_http/1 and put_http/2" do
    test "http /put test" do
      {:ok, resp} = HTTPClient.put_http("/put", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") == "this is data"
    end

    test "http put 404 error" do
      {:error, resp} = HTTPClient.put_http("/status/404", [])
      assert resp
    end
  end

  describe "patch_http/1 and patch_http/2" do
    test "http /patch test" do
      {:ok, resp} = HTTPClient.patch_http("/patch", ["this is data"])
      assert is_map(resp)
      assert Map.has_key?(resp, "data")
      assert Map.fetch!(resp, "data") == "this is data"
    end

    test "http patch 404 error" do
      {:error, resp} = HTTPClient.patch_http("/status/404", [])
      assert resp
    end
  end

  describe "delete_http/1 and delete_http/2" do
    test "http /delete test" do
      {:ok, resp} = HTTPClient.delete_http("/delete")
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
    end

    test "http /delete test with conditions" do
      {:ok, resp} = HTTPClient.delete_http("/delete", conditions: "key=value")
      assert is_map(resp)
      assert Map.has_key?(resp, "args")
      assert Map.fetch!(resp, "args") == %{"conditions" => "key=value"}
    end

    test "http delete 404 error" do
      {:error, resp} = HTTPClient.delete_http("/status/404", [])
      assert resp
    end
  end

  test "http get with conditions and fields" do
    {:ok, resp} = HTTPClient.get_http("/get", conditions: "key=value", fields: "id,length")
    assert is_map(resp)
    assert Map.has_key?(resp, "args")
    assert Map.fetch!(resp, "args") == %{"conditions" => "key=value", "fields" => "id,length"}
  end
end
