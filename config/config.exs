use Mix.Config

config :ex_cwmanage,
  http_timeout: 10_000,
  http_recv_timeout: 10_000

import_config "#{Mix.env()}.exs"
