defmodule BankOcr.AccountNumberTest do
  use ExUnit.Case

  import BankOcr.AccountNumber

  @account_number ["    _  _     _  _  _  _  _ \n",
                   "  | _| _||_||_ |_   ||_||_|\n",
                   "  ||_  _|  | _||_|  ||_| _|\n",
                   "\n"] # 4th line of the format is a blank line

  @digit_groups [
    ["   ", "  |", "  |"],
    [" _ ", " _|", "|_ "],
    [" _ ", " _|", " _|"],
    ["   ", "|_|", "  |"],
    [" _ ", "|_ ", " _|"],
    [" _ ", "|_ ", "|_|"],
    [" _ ", "  |", "  |"],
    [" _ ", "|_|", "|_|"],
    [" _ ", "|_|", " _|"],
  ]

  test "parses a string" do
    assert number_string_to_digit_strings(@account_number) == @digit_groups
  end

  test "converts digit groups to actual digits" do
    assert digit_strings_to_digits(@digit_groups) == [1,2,3,4,5,6,7,8,9]
  end
end
