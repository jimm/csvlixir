defmodule CSVLixir.Reader do

  @moduledoc """
  Reads a string or char_list and returns a list of lists whose values are
  of the same type.

  From http://www.trapexit.org/Comma_Separated_Values
  """

  def read(str) when is_binary(str) do
    {:ok, pid} = StringIO.open(str)
    CSVLixir.IOReader.rows(pid, &StringIO.close/1)
      |> Enum.to_list
  end
end
