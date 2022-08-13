defmodule UnLibD.MixProject do
  use Mix.Project

  def project do
    [
      name: "Unlibrary daemon",
      source_url: "https://github.com/unlibrary/readerd",
      app: :unlibd,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
end
