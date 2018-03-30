use Mix.Config

config :ex_cwmanage,
  http_timeout: 12_000,
  http_recv_timeout: 12_000

import_config "#{Mix.env()}.exs"
