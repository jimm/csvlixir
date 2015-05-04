defmodule CSVWriterTest do
  use ExUnit.Case

  @test_input [
    ["row one", "\"nasty:,\"", "has, comma", "has \"quotes\"", "has 'single quotes'"],
    ["has \"comma, in quotes\"", "has 'comma, in single quotes'", "quotes \",\" surrounding", "", ""],
    ["odd \"number of\" double \"quotes", "two, yes two, commas", "two, \"commas, second\" in quotes", "", ""],
    ["simple", "row", "internal \"quote", "", ""]
  ]

  # Expected results are tab-delimited. Lines that end with a backslash are
  # continued on the next line.
  @test_expected [
    "row one,\"\"\"nasty:,\"\"\",\"has, comma\",\"has \"\"quotes\"\"\",has 'single quotes'\n",
    "\"has \"\"comma, in quotes\"\"\",\"has 'comma, in single quotes'\",\"quotes \"\",\"\" surrounding\",,\n",
    "\"odd \"\"number of\"\" double \"\"quotes\",\"two, yes two, commas\",\"two, \"\"commas, second\"\" in quotes\",,\n",
    "simple,row,\"internal \"\"quote\",,\n"
  ]

  test "row writer" do
    both = Enum.zip @test_input, @test_expected
    Enum.each both, fn({input, expected}) -> write_row_test(input, expected) end
  end

  def write_row_test(input, expected) do
    row = CSVLixir.write_row(input)
    assert row == expected
  end

  test "multi-line column" do
    input = ["this row continues\non the next line"]
    expected = "\"this row continues\non the next line\"\n"

    row = CSVLixir.write_row(input)
    assert row == expected
  end
end
