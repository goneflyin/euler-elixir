defmodule Euler.Mixfile do
  use Mix.Project

  def project do
    [ app: :euler_cli,
      version: "0.0.1",
      elixir: "~> 0.12.4-dev",
      source_url: "https://github.com/goneflyin/euler-elixir",
      escript_main_module: Euler.Cli,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [  ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    []
  end
end
