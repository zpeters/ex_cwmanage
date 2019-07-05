defmodule ExCwmanage.Api.HTTPClient do
  @moduledoc """
  HTTP Interaction with the ConnectWise api.

  Handles generation of security token and and all http communication
  """

  require Logger

  @api_root Application.get_env(:ex_cwmanage, :cw_api_root)
  @timeout Application.get_env(:ex_cwmanage, :http_timeout)
  @recv_timeout Application.get_env(:ex_cwmanage, :http_recv_timeout)

  def generate_upload_form(rec_id, rec_type, file_path) do
    {:multipart, [{"RecordId", "#{rec_id}}"}, {"RecordType", rec_type},
                  {:file, file_path, {"form-data", [{:filename, Path.basename(file_path)}]}, []}]}
  end

  def get_http_raw(path, params \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, timeout: @timeout, recv_timeout: @recv_timeout),
         {:ok, _} <- status_check(http) do
      Logger.debug(fn -> "#{inspect(http)}" end)
      {:ok, http.body}
    else
      err ->
        err
    end
  end

  def get_http(path, params \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, timeout: @timeout, recv_timeout: @recv_timeout),
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
  end

  def get_http_page(path, params \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_pagination_headers(token),
         {:ok, url} <- generate_url(@api_root, path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.get(url, headers, timeout: @timeout, recv_timeout: @recv_timeout),
         {:ok, _} <- status_check(http),
         {:ok, resp} <- Jason.decode(http.body) do
      case next_page(http.headers) do
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
  end

  def post_http(path, payload) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path),
         {:ok, http} <-
           HTTPoison.post(url, payload, headers, timeout: @timeout, recv_timeout: @recv_timeout),
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
  end

  def put_http(path, payload) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path),
         {:ok, http} <-
           HTTPoison.put(url, payload, headers, timeout: @timeout, recv_timeout: @recv_timeout),
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
  end

  def patch_http(path, payload) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path),
         {:ok, http} <-
           HTTPoison.patch(url, payload, headers, timeout: @timeout, recv_timeout: @recv_timeout),
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
  end

  def delete_http(path, params \\ []) do
    with {:ok, token} <- generate_token(),
         {:ok, headers} <- generate_headers(token),
         {:ok, url} <- generate_url(@api_root, path, generate_parameters(params)),
         {:ok, http} <-
           HTTPoison.delete(url, headers, timeout: @timeout, recv_timeout: @recv_timeout),
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
      Accept: "application/vnd.connectwise.com+json; version=3.0.0",
      "Content-Type": "application/json",
      "Pagination-Type": "forward-only"
    ]

    {:ok, headers}
  end

  def generate_headers(token) do
    headers = [
      Authorization: "Basic #{token}",
      Accept: "application/vnd.connectwise.com+json; version=3.0.0",
      "Content-Type": "application/json",
      clientId: Application.get_env(:ex_cwmanage, :cw_clientid)
    ]

    {:ok, headers}
  end

  defp next_page(headers) do
    link = List.keyfind(headers, "Link", 0)
    Logger.debug fn ->
      "Checking for link in headers: #{inspect(headers)}"
    end

    case link do
      {"Link", url} ->
        url
        |> String.split("pageId=")
        |> List.last()
        |> String.split(">;")
        |> List.first()

      _ ->
        nil
    end
  end
end
