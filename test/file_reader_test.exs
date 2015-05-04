defmodule CSVFileReaderTest do
  use ExUnit.Case

  test "file reader" do
    path = create_input_file
    expected = CSVReaderTest.test_expected
    actual = CSVLixir.FileReader.rows(path)
      |> Enum.to_list
    File.rm(path)

    assert actual == expected
  end

  defp create_input_file do
    path = "/tmp/file_reader_test.csv"
    f = File.open!(path, [:write, :utf8])
    IO.write(f, CSVReaderTest.test_input)
    File.close(f)
    path
  end
end
