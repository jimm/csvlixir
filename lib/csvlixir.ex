defmodule CSVLixir do

  @moduledoc """

  Reads or writes CSV data. The reader reads a file or a list strings
  returns a list of lists whose values are of the same type.

  The writer takes a list or a list of lists and returns a string containing
  a single row or newline-separated rows.

  From http://www.trapexit.org/Comma_Separated_Values
  """

  @doc """
  Given a path to a file, returns a stream that generates lists of strings.

  ## Examples

      iex> f = File.open!("/tmp/csvlixir.csv", [:write])
      iex> IO.puts(f, "row,one")
      iex> IO.puts(f, "row,two")
      iex> File.close(f)
      iex> CSVLixir.read("/tmp/csvlixir.csv")
      ...>   |> Enum.to_list
      [["row", "one"], ["row", "two"]]
      iex> File.rm("/tmp/csvlixir.csv")
      :ok
  """
  def read(path), do: CSVLixir.FileReader.rows(path)

  @doc """
  Given a string, returns a list of lists of strings.

  ## Examples

      iex> CSVLixir.parse("abc,def,ghi\\n123,456,789")
      [["abc","def","ghi"],["123","456","789"]]

      iex> CSVLixir.parse(~s{abc,def,"gh"",""i"})
      [["abc", "def", "gh\\",\\"i"]]

      iex> f = File.open!("/tmp/csvlixir.csv", [:write])
      iex> IO.puts(f, "row,one")
      iex> IO.puts(f, "row,two")
      iex> File.close(f)
      iex> CSVLixir.parse(File.read!("/tmp/csvlixir.csv")) |> Enum.to_list
      [["row", "one"], ["row", "two"]]
      iex> File.rm("/tmp/csvlixir.csv")
      :ok
  """
  def parse(str), do: CSVLixir.StringReader.read(str)

  @doc """
  Returns a stream that transforms a list of lists into strings.

  `CSVLixir.write` transforms a possibly lazy list of lists into a stream of
  CSV strings. Each generated string ends with a newline.

  ## Examples

      iex> CSVLixir.write([["first", "row"], [123, 456]])
      ...>   |> Enum.to_list
      ["first,row\\n", "123,456\\n"]

  ### Writing to a file:

      Writing using streams:

      iex> f = File.open!("/tmp/csvlixir.csv", [:write])
      iex> 1..3
      ...>   |> Stream.map(&([&1, &1+1 ,&1+2]))
      ...>   |> CSVLixir.write
      ...>   |> Stream.each(&(IO.write(f, &1)))
      ...>   |> Stream.run
      iex> File.close(f)
      iex> File.read!("/tmp/csvlixir.csv")
      "1,2,3\\n2,3,4\\n3,4,5\\n"
      iex> File.rm("/tmp/csvlixir.csv")
      :ok

      Writing a line at a time:

      iex> f = File.open!("/tmp/csvlixir.csv", [:write, :utf8])
      iex> IO.write(f, CSVLixir.write_row(["garçon", "waiter"]))
      iex> IO.write(f, CSVLixir.write_row(["résumé", "resume"]))
      iex> File.close(f)
      iex> File.read!("/tmp/csvlixir.csv")
      "garçon,waiter\\nrésumé,resume\\n"
      iex> File.rm("/tmp/csvlixir.csv")
      :ok

      Don't forget to specify :utf8 when opening the file for writing if
      needed. (I often forget.)

  """
  def write(enum), do: CSVLixir.Writer.write(enum)

  @doc """
  Given a single list, return a single string.

  ## Examples

      iex> CSVLixir.write_row(["a", "b", "c"])
      "a,b,c\\n"
  """
  def write_row(list), do: CSVLixir.Writer.write_row(list)
end
