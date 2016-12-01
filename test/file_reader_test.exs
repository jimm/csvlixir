defmodule CSVFileReaderTest do
  use ExUnit.Case

  test "file reader" do
    path = create_input_file()
    expected = TestHelper.test_expected
    actual = path |> CSVLixir.FileReader.rows |> Enum.to_list
    File.rm(path)

    assert actual == expected
  end

  defp create_input_file do
    path = "/tmp/file_reader_test.csv"
    f = File.open!(path, [:write, :utf8])
    IO.write(f, TestHelper.test_input)
    File.close(f)
    path
  end
end
