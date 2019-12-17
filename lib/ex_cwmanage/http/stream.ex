defmodule ExCwmanage.Api.HTTPClient.Stream do
  @moduledoc """
  Provides a streaming interface for connectwise paginated results
  """

  require Logger

  defp api_client, do: ExCwmanage.Api.HTTPClient

  @doc """
  resource = {`path`, `params`}

  - path is the url (ie "/service/tickets")
  - params is a list keyword list of standard options (ie [fields: "id", conditions: "date > [2019-01-01]"])
  """
  def new(resource) do
    Stream.resource(
      fn -> fetch(resource) end,
      &process_page/1,
      fn _ -> nil end
    )
  end

  defp fetch(resource) do
    fetch(resource, nil)
  end

  defp fetch(resource, pageid) do
    {path, params, http_opts} = resource
    new_params = params ++ [pageid: pageid]
    {:ok, nextpage, results} = api_client().get_page(path, new_params, http_opts)

    {results, nextpage, resource}
  end

  defp process_page({nil, "", _resource}) do
    {:halt, nil}
  end

  defp process_page({[], "", _resource}) do
    {:halt, nil}
  end

  defp process_page({nil, nil, _resource}) do
    {:halt, nil}
  end

  defp process_page({[], nil, _resource}) do
    {:halt, nil}
  end

  defp process_page({nil, nextpage, resource}) do
    resource
    |> fetch(nextpage)
    |> process_page
  end

  defp process_page({items, nextpage, resource}) do
    {[items], {nil, nextpage, resource}}
  end
end
