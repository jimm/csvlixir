defmodule CsvReaderTest do
  use ExUnit.Case

  @test_input [
    "hi!",
    "1,really,simple,row",
    "row one,\"\"\"nasty:,\"\"\",\"has, comma\",\"has \"\"quotes\"\"\",has 'single quotes'",
    "\"has \"\"comma, in quotes\"\"\",\"has 'comma, in single quotes'\",\"quotes \"\",\"\" surrounding\",,",
    "\"odd \"\"number of\"\" double \"\"quotes\",\"two, yes two, commas\",\"two, \"\"commas, second\"\" in quotes\",,",
    "simple,row,\"internal \"\"quote\",,",
    "\"this row continues\non the next line\",hi!"
  ]

  # Expected results are tab-delimited.
  @test_expected [
    "hi!",
    "1\treally\tsimple\trow",
    "row one\t\"nasty:,\"\thas, comma\thas \"quotes\"\thas 'single quotes'",
    "has \"comma, in quotes\"\thas 'comma, in single quotes'\tquotes \",\" surrounding\t\t",
    "odd \"number of\" double \"quotes\ttwo, yes two, commas\ttwo, \"commas, second\" in quotes\t\t",
    "simple\trow\tinternal \"quote\t\t",
    "this row continues\non the next line\thi!"
  ]

  test "empty input" do
    assert CSVLixir.read("") == []
  end

  # Compare parsed @test_input with @test_expected.
  test "reader" do
    both = Enum.zip @test_input, @test_expected
    Enum.each both, fn({input, expected}) -> read_test(input, expected) end
  end

  def read_test(input, expected) do
    [row] = CSVLixir.read(input)
    expected_row = String.split(expected, "\t")
    assert row == expected_row
  end
end
