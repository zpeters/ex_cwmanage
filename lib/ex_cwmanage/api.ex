defmodule ExCwmanage.Api.Behaviour do
  @moduledoc """
  Raw API commands
  """

  @callback get(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback get(path :: String.t(), params :: list()) :: {:ok, map} | {:error, term()}
  @callback get(path :: String.t(), params :: list(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}

  @callback get_stream(path :: String.t()) :: {:ok, [map]}
  @callback get_stream(path :: String.t(), params :: list()) :: {:ok, [map]}
  @callback get_stream(path :: String.t(), params :: list(), http_opts :: list()) :: {:ok, [map]}

  @callback get_page(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback get_page(path :: String.t(), params :: list()) :: {:ok, map} | {:error, term()}
  @callback get_page(path :: String.t(), params :: list(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}

  @callback get_raw(path :: String.t()) :: {:ok, binary()} | {:error, term()}
  @callback get_raw(path :: String.t(), params :: list()) :: {:ok, binary()} | {:error, term()}
  @callback get_raw(path :: String.t(), params :: list(), http_opts :: list()) ::
              {:ok, binary()} | {:error, term()}

  @callback post(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback post(path :: String.t(), payload :: String.t()) :: {:ok, map} | {:error, term()}
  @callback post(path :: String.t(), payload :: String.t(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}

  @callback put(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback put(path :: String.t(), payload :: String.t()) :: {:ok, map} | {:error, term()}
  @callback put(path :: String.t(), payload :: String.t(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}

  @callback patch(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback patch(path :: String.t(), payload :: String.t()) :: {:ok, map} | {:error, term()}
  @callback patch(path :: String.t(), payload :: String.t(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}

  @callback delete(path :: String.t()) :: {:ok, map} | {:error, term()}
  @callback delete(path :: String.t(), params :: list()) :: {:ok, map} | {:error, term()}
  @callback delete(path :: String.t(), params :: list(), http_opts :: list()) ::
              {:ok, map} | {:error, term()}
end

defmodule ExCwmanage.Api do
  @moduledoc """
  API for Excwmanage, this forwards requests to the designated API client (defaults to HTTP)
  """
  @behaviour ExCwmanage.Api.Behaviour
  defp api_client,
    do: Application.get_env(:ex_cwmanage, :connectwise_api, ExCwmanage.Api.HTTPClient)

  def delete(path, params \\ [], http_opts \\ []) do
    api_client().delete(path, params, http_opts)
  end

  def get(path, params \\ [], http_opts \\ []) do
    api_client().get(path, params, http_opts)
  end

  def get_page(path, params \\ [], http_opts \\ []) do
    api_client().get_page(path, params, http_opts)
  end

  def get_raw(path, params \\ [], http_opts \\ []) do
    api_client().get_raw(path, params, http_opts)
  end

  def get_stream(path, params \\ [], http_opts \\ []) do
    api_client().get_stream(path, params, http_opts)
  end

  def patch(path, payload \\ %{}, http_opts \\ []) do
    api_client().patch(path, payload, http_opts)
  end

  def put(path, payload \\ %{}, http_opts \\ []) do
    api_client().put(path, payload, http_opts)
  end

  def post(path, payload \\ %{}, http_opts \\ []) do
    api_client().post(path, payload, http_opts)
  end
end
