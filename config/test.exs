use Mix.Config

config :logger,
  level: :info

config :ex_cwmanage, :connectwise_api, ExCwmanage.Api.Mock
