defmodule BankOcr.AccountNumberTest do
  use ExUnit.Case

  import BankOcr.AccountNumber
  import Enum

  @account_number Enum.join(["    _  _     _  _  _  _  _ ",
                             "  | _| _||_||_ |_   ||_||_|",
                             "  ||_  _|  | _||_|  ||_| _|",
                             ""], # 4th line of the format is a blank line
                            "\n")

  test "parses a string" do
    expected = [
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
    assert number_string_to_digit_strings(@account_number) == expected
  end
end
