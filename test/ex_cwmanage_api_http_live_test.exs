defmodule ExCwmanageApiHTTPTest do
  use ExUnit.Case
  doctest ExCwmanage

  alias ExCwmanage.Api.HTTPClient

  setup_all do
    live_environment()

    on_exit(fn ->
      test_environment()
    end)
  end

  def live_environment do
    Application.put_env(
      :ex_cwmanage,
      :cw_api_root,
      "https://api-na.myconnectwise.net/v4_6_release/apis/3.0"
    )

    Application.put_env(:ex_cwmanage, :cw_companyid, "buscominctraining")
    Application.put_env(:ex_cwmanage, :cw_publickey, "2UghtKJ4bzr5N6Ip")
    Application.put_env(:ex_cwmanage, :cw_privatekey, "v4MbpC6jRGxHRfZf")
    Application.put_env(:ex_cwmanage, :cw_clientid, "b25d129d-dcf6-4b34-8cb3-33259d40ccbf")
  end

  def test_environment do
    Application.delete_env(:ex_cwmanage, :cw_api_root)
    Application.delete_env(:ex_cwmanage, :cw_api_root)
    Application.delete_env(:ex_cwmanage, :cw_companyid)
    Application.delete_env(:ex_cwmanage, :cw_publickey)
    Application.delete_env(:ex_cwmanage, :cw_privatekey)
    Application.delete_env(:ex_cwmanage, :cw_clientid)
  end

  describe "get_stream/1 and get_stream/2" do
    @tag :live
    test "get a stream" do
      path = "/system/members"
      params = [fields: "id", pagesize: 1]
      {:ok, results} = HTTPClient.get_stream(path, params)
      assert results != nil
    end
  end

  @tag :live
  test "test get page default" do
    {:ok, next, resp} = HTTPClient.get_page("/company/companies")
    assert next != nil
    assert next > 0
    assert is_list(resp)
  end

  @tag :live
  test "test get raw page (no json)" do
    {:ok, resp} = HTTPClient.get_raw("/system/info")
    assert is_binary(resp)
  end

  @tag :live
  test "test get no conditions" do
    {:ok, resp} = HTTPClient.get("/system/info")
    assert is_map(resp)
    assert Map.has_key?(resp, "version")
  end

  @tag :live
  test "test bad path" do
    {:error, resp} = HTTPClient.get("/badpath")
    assert resp.status_code == 404
  end

  @tag :live
  test "get with conditions" do
    {:ok, resp} = HTTPClient.get("/service/locations")
    {:ok, resp2} = HTTPClient.get("/service/locations", conditions: "id=1")
    assert length(resp) > 0
    assert length(resp2) > 0
    assert length(resp) > length(resp2)
  end

  # test "post function returns placeholder :ok" do
  #   @mock
  #   |> expect(:post, fn _path, _payload ->
  #     {:ok, %{}}
  #   end)

  #   {:ok, resp} = ExCwmanage.Api.post("/", %{})
  #   assert is_map(resp)
  # end

  # test "patch function returns placeholder :ok" do
  #   @mock
  #   |> expect(:patch, fn _path, _payload ->
  #     {:ok, %{}}
  #   end)

  #   {:ok, resp} = ExCwmanage.Api.patch("/", %{})
  #   assert is_map(resp)
  # end

  # test "put function returns placeholder :ok" do
  #   @mock
  #   |> expect(:put, fn _path, _payload ->
  #     {:ok, %{}}
  #   end)

  #   {:ok, resp} = ExCwmanage.Api.put("/", %{})
  #   assert is_map(resp)
  # end

  # test "delete function returns placeholder :ok" do
  #   @mock
  #   |> expect(:delete, fn _path, _params ->
  #     {:ok, %{}}
  #   end)

  #   {:ok, resp} = ExCwmanage.Api.delete("/")
  #   assert is_map(resp)
  # end
end
