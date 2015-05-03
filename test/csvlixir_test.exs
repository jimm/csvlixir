Code.require_file "test_helper.exs", __DIR__

defmodule CSVLixirTest do
  use ExUnit.Case

  test "parse a string" do
    assert CSVLixir.parse("foo") == [["foo"]]
  end

  test "parse multiple rows" do
    assert CSVLixir.parse("abc\ndef") == [["abc"], ["def"]]
  end

  test "read and parse multiple rows from a file" do
    path = "/tmp/csvlixir_test.csv"
    f = File.open!(path, [:write])
    IO.write(f, "abc\ndef")
    File.close(f)

    answer = CSVLixir.read(path) |> Enum.to_list
    File.rm(path)

    assert answer == [["abc"], ["def"]]
  end

  test "write row" do
    assert CSVLixir.write_row(["a", "b", "c"]) == "a,b,c"
  end

  test "write list of lists" do
    assert CSVLixir.write([[123, 456], ["abc", "def"]]) == "123,456\nabc,def"
  end

  test "write list of values => write_row" do
    assert CSVLixir.write(["a", "b", "c"]) == "a,b,c"
  end
end
