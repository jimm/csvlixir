defmodule Csv.Mixfile do
  use Mix.Project

  def project do
    [ app: :csvlixir,
      version: "1.0.0",
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
    []
  end

  def description do
    """
CSVLixir is a CSV reader/writer for Elixir. It operates on strings and char
lists.

The reader takes a string or a char list and returns a list of lists of the
same type.

The writer takes a list of lists (write) or a list (write_row) and returns a
string. The writer always works with strings.
"""
  end

  defp package do
    [
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/jimm/csvlixir"},
     contributors: ["Jim Menard"]
     ]
  end
end
