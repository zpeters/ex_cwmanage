defmodule ExCwmanage.Api do
  @moduledoc """
  This is the main API logic.  Currently we only support GET with the 'conditions' as an option.
  Eventually this will encompass all of the HTTP verbs and the allowable ConnectWise 'parameters'
  """
  @connectwise_api Application.get_env(:ex_cwmanage, :connectwise_api)

  @callback get(path :: String.t(), opts :: list()) :: %{}
  def get(path, opts \\ []) do
    @connectwise_api.get(path, opts)
  end

  @callback post(path :: String.t(), payload :: String.t()) :: %{}
  def post(path, payload) do
    @connectwise_api.post(path, payload)
  end
end
