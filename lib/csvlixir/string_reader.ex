defmodule CSVLixir.StringReader do

  @moduledoc """
  Reads a string and returns a list of lists of strings.
  """

  def read(str) when is_binary(str) do
    {:ok, pid} = StringIO.open(str)
    CSVLixir.IOReader.rows(pid, &StringIO.close/1)
      |> Enum.to_list
  end
end
