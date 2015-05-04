defmodule CSVLixir.FileReader do

  @moduledoc """
  Reads UTF-8 characters from a file and returns a Stream of lists of
  strings.
  """

  def rows(path) do
    f = File.open!(path, [:utf8])
    CSVLixir.IOReader.rows(f, &File.close/1)
  end
end
