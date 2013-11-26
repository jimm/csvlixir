defmodule CsvReaderTest do
  use ExUnit.Case

  @test_input [
    "row one,\"\"\"nasty:,\"\"\",\"has, comma\",\"has \"\"quotes\"\"\",has 'single quotes'",
    "\"has \"\"comma, in quotes\"\"\",\"has 'comma, in single quotes'\",\"quotes \"\",\"\" surrounding\",,",
    "\"odd \"\"number of\"\" double \"\"quotes\",\"two, yes two, commas\",\"two, \"\"commas, second\"\" in quotes\",,",
    "simple,row,\"internal \"\"quote\",,"
  ]

  # Expected results are tab-delimited. Lines that end with a backslash are
  # continued on the next line.
  @test_expected [
    "row one	\"nasty:,\"	has, comma	has \"quotes\"	has 'single quotes'",
    "has \"comma, in quotes\"	has 'comma, in single quotes'	quotes \",\" surrounding		",
    "odd \"number of\" double \"quotes	two, yes two, commas	two, \"commas, second\" in quotes		",
    "simple	row	internal \"quote		"
  ]

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

  test "multi-line column" do
    input = "\"this row continues\non the next line\""
    expected = "this row continues\non the next line"

    [[row]] = CSVLixir.read(input)
    assert row == expected
  end
end
