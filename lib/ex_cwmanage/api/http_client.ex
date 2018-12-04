defmodule ExCwmanage.Api.HTTPClient do
  @moduledoc """
  HTTP Client implementation of the ConnectWise API
  """



  def get_http(path, opts \\ []) do
    with {:ok, url} <- generate_url(path),
      {:ok, headers} <- generate_headers(),
      {:ok, options} <- generate_options(opts),
      {:ok, http} <- HTTPoison.get(url, headers, options),
      {:ok, resp} <- Jason.decode(http.body) do
      {:ok, resp}
    else
      err -> err
    end
  end

  def post_http(path, payload) do
    with {:ok, url} <- generate_url(path),
    {:ok, headers} <- generate_headers(),
    {:ok, http} <- HTTPoison.post(url, payload, headers),
    {:ok, resp} <- Jason.decode(http.body) do
    {:ok, resp}
    else
      err -> err
    end
  end

  def put_http(path, payload) do
    with {:ok, url} <- generate_url(path),
    {:ok, headers} <- generate_headers(),
    {:ok, http} <- HTTPoison.put(url, payload, headers),
    {:ok, resp} <- Jason.decode(http.body) do
    {:ok, resp}
    else
      err -> err
    end
  end

  def patch_http(path, payload) do
    url = generate_url(path)
    headers = generate_headers()

    {:ok, resp} = HTTPoison.patch(url, payload, headers)

    body =
      resp
      |> Map.fetch!(:body)
      |> Jason.decode!

    {:ok, body}
  end

  def delete_http(path, opts \\ []) do
    url = generate_url(path)
    headers = generate_headers()
    options = [query: opts]

    {:ok, resp} = HTTPoison.delete(url, headers, options)

    body =
      resp
      |> Map.fetch!(:body)
      |> Jason.decode!

    {:ok, body}
  end

  defp generate_url(path) do
    root = Application.get_env(:ex_cwmanage, :cw_api_root)
    {:ok, "#{root}#{path}"}
  end

  defp generate_headers do
    headers = [
      {"Authorization", "Basic #{generate_token()}"},
      {"Accept", "application/vnd.connectwise.com+json; version=3.0.0"},
      {"Content-Type", "application/json"}
    ]
    {:ok, headers}
  end

  defp generate_token do
    id = Application.get_env(:ex_cwmanage, :cw_companyid)
    pub = Application.get_env(:ex_cwmanage, :cw_publickey)
    priv = Application.get_env(:ex_cwmanage, :cw_privatekey)
    token = "#{id}+#{pub}:#{priv}"
    Base.encode64(token)
  end

  defp generate_options(opts) do
      if opts == [] do
        {:ok, []}
      else
        {:ok, [params: [{"conditions", Keyword.get(opts, :conditions)}]]}
      end
  end

end
