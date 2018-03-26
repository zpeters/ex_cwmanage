defmodule ExCwmanage.Api do
  def get(path) do
    with {:ok, token} <- generate_token(),
         {:ok, header} <- generate_header(token),
         {:ok, url} <- generate_url(path, []),
         {:ok, http} <- HTTPoison.get(url, header, []),
         {:ok, resp} <- Poison.decode(http.body)
      do
      {:ok, resp}
      else
        err -> err
    end
  end

  def get(path, conditions) do
    with {:ok, token} <- generate_token(),
         {:ok, header} <- generate_header(token),
         {:ok, url} <- generate_url(path, "?conditions=#{conditions}"),
         {:ok, http} <- HTTPoison.get(url, header, []),
         {:ok, resp} <- Poison.decode(http.body)
      do
      {:ok, resp}
      else
        err -> err
    end
  end

  defp generate_token() do
    id = Application.get_env(:ex_cwmanage, :cw_companyid)
    pub = Application.get_env(:ex_cwmanage, :cw_publickey)
    priv = Application.get_env(:ex_cwmanage, :cw_privatekey)
    token = "#{id}+#{pub}:#{priv}"
    {:ok, Base.encode64(token)}
  end

  defp generate_header(token) do
    headers = ["Authorization": "Basic #{token}",
               "Accept": "application/vnd.connectwise.com+json; version=3.0.0",
               "Content-Type": "application/json"]
    {:ok, headers}
  end

  defp generate_url(path, conditions) do
    root = Application.get_env(:ex_cwmanage, :cw_api_root)
    url = "#{root}#{path}#{conditions}"
    {:ok, url}
  end
end
