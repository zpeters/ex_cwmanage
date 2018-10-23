use Mix.Config

config :ex_cwmanage,
  cw_api_root: "https://httpbin.org/",
  cw_companyid: "fake",
  cw_publickey: "public",
  cw_privatekey: "private"

## Sandbox Apis
config :ex_cwmanage, :connectwise_api, ExCwmanage.Api.Sandbox
