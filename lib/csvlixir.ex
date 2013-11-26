defmodule CSVLixir do

  @moduledoc """

  Reads or writes CSV data. The reader reads a string or char_list and
  returns a list of lists whose values are of the same type.

  The writer takes a list or a list of lists and returns a string containing
  a single row or newline-separated rows.

  From http://www.trapexit.org/Comma_Separated_Values
  """

  def read(str_or_char_list), do: CSVLixir.Reader.read(str_or_char_list)

  def write([h|t]) when is_list(h), do: CSVLixir.Writer.write([h|t])
  def write(list), do: CSVLixir.Writer.write_row(list)
  def write_row(list), do: CSVLixir.Writer.write_row(list)
end
