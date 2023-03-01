defmodule UnLibD.MixProject do
  use Mix.Project

  def project do
    [
      name: "Unlibrary daemon",
      source_url: "https://github.com/libre0b11/unlibd",
      app: :unlibd,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps() ++ check_deps(),
      package: package()
    ]
  end

  def application do
    [
      mod: {UnLibD.Application, []},
      env: [interval: :timer.minutes(2), autopull: true],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:unlib, path: "../reader"}
    ]
  end

  defp check_deps do
    [
      {:ex_check, "~> 0.14.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Robin Boers"],
      organization: "0b11",
      links: %{github: "https://github.com/libre0b11/unlib"}
    ]
  end
end
