defmodule ExCwmanage.Api do
  @moduledoc """
  Raw API commands
  """

  @type path :: String.t()

  defp connectwise_api,
    do: Application.get_env(:ex_cwmanage, :connectwise_api, ExCwmanage.Api.HTTPClient)

  @callback get_raw(path :: path, params :: list()) :: binary()
  def get_raw(path, params \\ []) do
    connectwise_api().get_http_raw(path, params)
  end

  @callback get(path :: path, params :: list()) :: map
  def get(path, params \\ []) do
    connectwise_api().get_http(path, params)
  end

  @callback get_stream(path :: path, params :: list()) :: map
  def get_stream(path, params \\[]) do
    connectwise_api().get_http_stream(path,params)
  end

  @callback get_page(path :: path, params :: list()) :: map
  @doc """
  Example
  Initial call `{:ok, next, c} = ExCwmanage.Api.get_page("/company/companies")`
  Next page `{:ok, next, c} = ExCwmanage.Api.get_page("/company/companies", [pageid: next])`
  Next page (custom page size) `{:ok, next, c} = ExCwmanage.Api.get_page("/company/companies", [pageid: next], [pagesize: 10])`
  """
  def get_page(path, params \\ []) do
    connectwise_api().get_http_page(path, params)
  end

  @callback post(path :: path, payload :: String.t()) :: map
  def post(path, payload) do
    connectwise_api().post_http(path, payload)
  end

  @callback put(path :: path, payload :: String.t()) :: map
  def put(path, payload) do
    connectwise_api().put_http(path, payload)
  end

  @callback patch(path :: path, payload :: String.t()) :: map
  def patch(path, payload) do
    connectwise_api().patch_http(path, payload)
  end

  @callback delete(path :: path, params :: list()) :: map
  def delete(path, params \\ []) do
    connectwise_api().delete_http(path, params)
  end
end
