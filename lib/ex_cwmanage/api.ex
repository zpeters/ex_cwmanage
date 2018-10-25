defmodule ExCwmanage.Api do
  @moduledoc """
  Raw API commands
  """

  @type path :: String.t()

  @connectwise_api Application.get_env(:ex_cwmanage, :connectwise_api, ExCwmanage.Api.HTTPClient)

  @doc """
  Get a http resource

  Examples:
  `get("/system/info")`
  `get("/finances/invoices/count", [:conditions, "id=1234"])`
  """
  @callback get(path :: path, opts :: list()) :: map
  def get(path, opts \\ []) do
    @connectwise_api.get(path, opts)
  end

  @callback post(path :: path, payload :: String.t()) :: map
  def post(path, payload) do
    @connectwise_api.post(path, payload)
  end

  @callback put(path :: path, payload :: String.t()) :: map
  def put(path, payload) do
    @connectwise_api.put(path, payload)
  end

  @callback patch(path :: path, payload :: String.t()) :: map
  def patch(path, payload) do
    @connectwise_api.patch(path, payload)
  end

  @callback delete(path :: path, opts :: list()) :: map
  def delete(path, opts \\ []) do
    @connectwise_api.delete(path, opts)
  end
end
