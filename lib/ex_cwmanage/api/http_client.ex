defmodule ExCwmanage.Api.HTTPClient do
  @moduledoc """
  HTTP Client implementation of the ConnectWise API
  """
  use Tesla

  @api_root Application.get_env(:ex_cwmanage, :cw_api_root)

  plug(Tesla.Middleware.BaseUrl, @api_root)

  plug(Tesla.Middleware.Headers, [
    {"Authorization", "Basic #{generate_token()}"},
    {"Accept", "application/vnd.connectwise.com+json; version=3.0.0"},
    {"Content-Type", "application/json"}
  ])

  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Logger)

  def get_http(path, opts \\ []) do
    {:ok, resp} = get(path, query: opts)

    body =
      resp
      |> Map.fetch!(:body)

    {:ok, body}
  end

  def post_http(path, payload) do
    {:ok, resp} = post(path, payload)

    body =
      resp
      |> Map.fetch!(:body)

    {:ok, body}
  end

  def put_http(path, payload) do
    {:ok, resp} = put(path, payload)

    body =
      resp
      |> Map.fetch!(:body)

    {:ok, body}
  end

  def patch_http(path, payload) do
    {:ok, resp} = patch(path, payload)

    body =
      resp
      |> Map.fetch!(:body)

    {:ok, body}
  end

  def delete_http(path, opts \\ []) do
    {:ok, resp} = delete(path, query: opts)

    body =
      resp
      |> Map.fetch!(:body)

    {:ok, body}
  end

  defp generate_token do
    id = Application.get_env(:ex_cwmanage, :cw_companyid)
    pub = Application.get_env(:ex_cwmanage, :cw_publickey)
    priv = Application.get_env(:ex_cwmanage, :cw_privatekey)
    token = "#{id}+#{pub}:#{priv}"
    Base.encode64(token)
  end
end
