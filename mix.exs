defmodule CSVLixir.Mixfile do
  use Mix.Project

  def project do
    [ app: :csvlixir,
      version: "2.0.3",
      deps: deps,
      description: description,
      package: package]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:earmark, "~> 0.2.1", only: :dev},
     {:ex_doc, "~> 0.11.4", only: :dev}]
  end

  def description do
    """
CSVLixir is a CSV reader/writer for Elixir. It operates on files and
strings.

The reader can read CSV files or CSV strings. Reading from files returns a
stream of lists. Reading from strings returns a list of lists.

The writer transforms a (possibly lazy) list of lists into a stream of CSV
strings. It can also take a single list and return a single CSV string.
"""
  end

  defp package do
    [
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/jimm/csvlixir"},
     maintainers: ["Jim Menard"]
     ]
  end
end
