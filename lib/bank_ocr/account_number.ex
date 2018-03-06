defmodule BankOcr.AccountNumber do
  @moduledoc """
  Parses full account numbers from OCR formatted strings.
  """

  import BankOcr.DigitParser, only: [parse_digit: 1]

  @doc """
  digit_strings_to_digits parses a list of digit strings into actual numeric digits.
  A digit_string for input is 3 strings, representing the [top, middle, bottom] of
  the digit, where top, middle, and bottom are each length 3.
  """
  def digit_strings_to_digits([]), do: []
  def digit_strings_to_digits([digit_string | digit_strings]) do
    [parse_digit(digit_string) | digit_strings_to_digits(digit_strings)]
  end

  @doc """
  number_string_to_digit_strings takes input as it will be from the file with 4 rows of characters,
  and then splits them into a list of 3x3 character groups each representing a single digit.
  """
  def number_string_to_digit_strings(number) do
    [row1, row2, row3, ""] = String.split(number, "\n")
    rows_to_digit_strings(String.to_charlist(row1), String.to_charlist(row2), String.to_charlist(row3))
  end

  defp rows_to_digit_strings([], [], []), do: []
  defp rows_to_digit_strings([a,b,c|row1], [d,e,f|row2], [g,h,i|row3]) do
    head = [List.to_string([a,b,c]), List.to_string([d,e,f]), List.to_string([g,h,i])] 
    [head | rows_to_digit_strings(row1, row2, row3)]
  end
end

