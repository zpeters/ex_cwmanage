defmodule ExCwmanage.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_cwmanage,
      version: "0.1.0",
      elixir: "~> 1.0.2",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        main: "ExCwmanage",
        extras: ["README.md"]
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:excoveralls, "~> 0.8", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
