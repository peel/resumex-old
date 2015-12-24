defmodule Resume.Mixfile do
  use Mix.Project

  def project do
    [app: :resume,
     version: "0.0.1",
     elixir: "~> 1.1",
     escript: escript,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def escript do
    [main_module: Resume.CLI]
  end

  def application do
    [applications: [:logger, :oauth2, :cowboy, :plug]]
  end

  defp deps do
    [
      {:oauth2, "~> 0.5"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:httpoison, "~> 0.8.0"}
    ]
  end
end
