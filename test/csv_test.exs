Code.require_file "test_helper.exs", __DIR__

defmodule CsvTest do
  use ExUnit.Case

  test "read string" do
    assert CSV.read("foo") == [["foo"]]
  end

  test "read char list" do
    assert CSV.read('foo') == [['foo']]
  end

  test "read multiple rows" do
    assert CSV.read("abc\ndef") == [["abc"], ["def"]]
  end

  test "read multiple rows in char list" do
    assert CSV.read('abc\ndef') == [['abc'], ['def']]
  end

  test "write row" do
    assert CSV.write_row(["a", "b", "c"]) == "a,b,c"
  end

  test "write list of lists" do
    assert CSV.write([[123, 456], ["abc", "def"]]) == "123,456\nabc,def"
  end

  test "write list of values => write_row" do
    assert CSV.write(["a", "b", "c"]) == "a,b,c"
  end
end
