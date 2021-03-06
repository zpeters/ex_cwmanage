defmodule ExCwmanage.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_cwmanage,
      name: "ExCwmanage",
      version: "0.3.9",
      elixir: "~> 1.9",
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
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/zpeters/ex_cwmanage",
      homepage_url: "https://github.com/zpeters/ex_cwmanage"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "ConnectWise Manage library for Elixir."
  end

  defp package() do
    [
      licenses: ["GPL v3.0"],
      links: %{
        "GitHub" => "https://github.com/zpeters/ex_cwmanage",
        "ConnectWise Manage API" => "https://developer.connectwise.com/Products"
      }
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14.0", only: :test},
      {:httpoison, "~> 1.8.0"},
      {:jason, "~> 1.2.0"},
      {:mox, "~> 1.0.0", only: :test}
    ]
  end
end
