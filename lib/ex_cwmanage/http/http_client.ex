defmodule ExCwmanage.Api.HTTPClient do
  @moduledoc """
  HTTP Interaction with the ConnectWise api.

  Handles generation of security token and and all http communication
  """
  @behaviour ExCwmanage.Api.Behaviour

  alias ExCwmanage.Api.HTTPClient.Stream

  require Logger

  defp api_root, do: Application.get_env(:ex_cwmanage, :cw_api_root)

  @impl ExCwmanage.Api.Behaviour
  def get(path, params \\ [], http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, resp}
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  def generate_upload_form(rec_id, rec_type, file_path) do
    {:multipart,
     [
       {"RecordId", "#{rec_id}}"},
       {"RecordType", rec_type},
       {:file, file_path, {"form-data", [{:filename, Path.basename(file_path)}]}, []}
     ]}
  end

  @impl ExCwmanage.Api.Behaviour
  def get_raw(path, params \\ [], http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, http_opts),
         {:ok, _} <- status_check(http) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, http.body}
    else
      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def get_stream(path, params \\ [], http_opts \\ []) do
    results =
      {path, params, http_opts}
      |> Stream.new()
      |> Enum.map(& &1)
      |> List.flatten()

    {:ok, results}
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def get_page(path, params \\ [], http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_pagination_headers(token),
         {:ok, url} <- generate_url(api_root(), path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      case next_page(params[:pageid], http.headers) do
        nil ->
          {:ok, nil, resp}

        page ->
          {:ok, page, resp}
      end
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def post(path, payload \\ %{}, http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path),
         {:ok, http} <-
           HTTPoison.post(url, payload, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, resp}
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def put(path, payload \\ %{}, http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path),
         {:ok, http} <-
           HTTPoison.put(url, payload, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, resp}
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def patch(path, payload \\ %{}, http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path),
         {:ok, http} <-
           HTTPoison.patch(url, payload, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, resp}
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  @impl ExCwmanage.Api.Behaviour
  def delete(path, params \\ [], http_opts \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(api_root(), path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.delete(url, headers, http_opts),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, resp}
    else
      {:error, :invalid, 0} ->
        {:error, :invalid_body_decode}

      err ->
        err
    end
  rescue
    exception ->
      {:error, exception}
  end

  def generate_url(api_root, path, conditions \\ []) do
    url = "#{api_root}#{path}#{conditions}"
    {:ok, url}
  end

  def generate_parameters(parameters) do
    case parameters do
      [] ->
        []

      _ ->
        parms =
          parameters
          |> Keyword.keys()
          |> Enum.map(&"#{&1}=#{Keyword.get(parameters, &1)}")
          |> Enum.join("&")

        "?#{parms}"
        |> URI.encode()
    end
  end

  defp status_check(http_response) do
    case http_response.status_code do
      200 ->
        {:ok, http_response}

      201 ->
        {:ok, http_response}

      _ ->
        {:error, http_response}
    end
  end

  defp generate_token do
    id = Application.get_env(:ex_cwmanage, :cw_companyid)
    pub = Application.get_env(:ex_cwmanage, :cw_publickey)
    priv = Application.get_env(:ex_cwmanage, :cw_privatekey)
    token = "#{id}+#{pub}:#{priv}"
    {:ok, Base.encode64(token)}
  end

  defp generate_pagination_headers(token) do
    headers = [
      Authorization: "Basic #{token}",
      Accept: "application/vnd.connectwise.com+json",
      "Content-Type": "application/json",
      clientId: Application.get_env(:ex_cwmanage, :cw_clientid),
      "Pagination-Type": "forward-only"
    ]

    {:ok, headers}
  end

  def generate_headers(token) do
    headers = [
      Authorization: "Basic #{token}",
      Accept: "application/vnd.connectwise.com+json",
      "Content-Type": "application/json",
      clientId: Application.get_env(:ex_cwmanage, :cw_clientid)
    ]

    {:ok, headers}
  end

  defp next_page(current_pageid, headers) do
    link = List.keyfind(headers, "Link", 0)

    Logger.debug(fn ->
      "Checking for link in headers: #{inspect(headers)}"
    end)

    case link do
      {"Link", ""} ->
        nil

      {"Link", url} ->
        next_pageid =
          url
          |> String.split("pageId=")
          |> List.last()
          |> String.split(">;")
          |> List.first()

        # FIXME: there is a bug in the connectwise api where some endpoints
        # will return their current pageid as the next pageid instead of  no link
        # this is a work around
        if next_pageid == current_pageid do
          Logger.debug("Detected nextpage == current page, returning nil")
          nil
        else
          next_pageid
        end

      _ ->
        nil
    end
  end
end
