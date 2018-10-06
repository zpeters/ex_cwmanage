defmodule ExCwmanage.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_cwmanage,
      name: "ExCwmanage",
      version: "0.1.0",
      elixir: "~> 1.6",
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
      source_url: "https://github.com/zpeters/ex_cwmanage" # Used to link to code from ExDoc generated docs
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
      links: %{"GitHub" => "https://github.com/zpeters/ex_cwmanage"}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.3.1"},
      {:poison, "~> 4.0.1"},
      {:excoveralls, "~> 0.10.1", only: :test},
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19.1", only: :dev, runtime: false},
      {:inch_ex, only: :docs}
    ]
  end
end
