defmodule CSVLixir do

  @moduledoc """

  Reads or writes CSV data. The reader reads a file or a list strings
  returns a list of lists whose values are of the same type.

  The writer takes a list or a list of lists and returns a string containing
  a single row or newline-separated rows.

  From http://www.trapexit.org/Comma_Separated_Values
  """

  @doc "Returns a stream that generates lists of strings."
  def read(path), do: CSVLixir.FileReader.rows(path)

  @doc "Given a string, returns a list of lists of strings."
  def parse(str), do: CSVLixir.Reader.read(str)

  @doc "Given a list of lists, return a string containing multiple CSV rows."
  def write([h|t]) when is_list(h), do: CSVLixir.Writer.write([h|t])
  def write(list), do: CSVLixir.Writer.write_row(list)

  @doc "Given a list of values, return a single CSV row as a string"
  def write_row(list), do: CSVLixir.Writer.write_row(list)
end
