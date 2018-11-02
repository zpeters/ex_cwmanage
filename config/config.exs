use Mix.Config

config :ex_cwmanage,
  http_timeout: 12_000,
  http_recv_timeout: 12_000

config :tesla,
       Tesla.Middleware.Logger,
       debug: false

import_config "#{Mix.env()}.exs"
