defmodule BankOcr.DigitParserTest do
  use ExUnit.Case

  import BankOcr.DigitParser

  test "parses a 1" do
    one = ["   ",
           "  |",
           "  |"]
    
    assert parse_digit(one) == 1
  end
end
