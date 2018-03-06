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

  test "checksum for a valid account number" do
    assert checksum([4,5,7,5,0,8,0,0,0])
  end

  test "checksum for an invalid account number" do
    assert !checksum([6,6,4,3,7,1,4,9,5])
  end

  test "checksum for an account number that's not 9 digits" do
    assert !checksum([4,5,7,5,0,8,0,0])
  end
end
