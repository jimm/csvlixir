defmodule CSVLixir.Writer do

  @moduledoc """
  The writer takes a list (write_row) or a list of lists (wrote) and returns
  a string containing a single row or newline-separated rows.
  """

  def write(list) do
    list
    |> Enum.map(&write_row/1)
    |> Enum.join("\n")
  end

  def write_row(list), do: write_row(list, [])

  defp write_row([], cols), do: Enum.join(:lists.reverse(cols), ",")

  defp write_row([h|t], cols), do: write_row(t, [escape(h) | cols])

  defp escape(str) when is_binary(str) do
    if Regex.match?(~r{[\",\n]}, str) do
      "\"" <> String.replace(str, "\"", "\"\"") <> "\""
    else
      str
    end
  end

  defp escape(term), do: escape(inspect(term))
end
