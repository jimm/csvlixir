defmodule CSVStringReaderTest do
  use ExUnit.Case

  test "empty input" do
    assert CSVLixir.parse("") == []
  end

  # Compare parsed @test_input with @test_expected.
  test "reader" do
    assert CSVLixir.StringReader.read(TestHelper.test_input) == TestHelper.test_expected
  end
end
