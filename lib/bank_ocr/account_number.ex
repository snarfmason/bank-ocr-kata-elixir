defmodule BankOcr.AccountNumber do
  @moduledoc """
  Parses full account numbers from OCR formatted strings.
  """

  import BankOcr.DigitParser, only: [parse_digit: 1]

  @doc """
  Format a list of digits for display.
  """
  def format_for_display(digits) do
    "#{Enum.join(digits, "")}#{display_suffix(digits)}"
  end

  defp display_suffix(digits), do: display_suffix(digits, checksum(digits))
  defp display_suffix(_digits, true), do: ""
  defp display_suffix(_digits, false), do: " ERR"

  @doc """
  Performs the checksum on an account number. digits is expected to have the format
  returned by digit_strings_to_digits which is a length 9 list of 0-9

  checksum detais:
    account number:  3  4  5  8  8  2  8  6  5
    position names:  d9 d8 d7 d6 d5 d4 d3 d2 d1
    checksum calculation: (d1 + 2*d2 + 3*d3 +..+ 9*d9) mod 11 = 0
  """
  def checksum(digits) when length(digits) == 9 do
    c = calculate_checksum(digits, 9)
    rem(c, 11) == 0
  end
  def checksum(_), do: false # not 9 digits

  defp calculate_checksum([], _), do: 0
  defp calculate_checksum([d | digits], n) do
    d*n + calculate_checksum(digits, n-1)
  end

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
  These have "\n" at the end now that I have to strip off.
  Note: the file format specifies 4 lines where one is blank, thus the last "\n"
  """
  def number_string_to_digit_strings([row1, row2, row3, "\n"]) do
    {:ok, r1} = row_to_charlist(row1)
    {:ok, r2} = row_to_charlist(row2)
    {:ok, r3} = row_to_charlist(row3)
    rows_to_digit_strings(r1,r2,r3)
  end

  defp rows_to_digit_strings([], [], []), do: []
  defp rows_to_digit_strings([a,b,c|row1], [d,e,f|row2], [g,h,i|row3]) do
    head = [List.to_string([a,b,c]), List.to_string([d,e,f]), List.to_string([g,h,i])] 
    [head | rows_to_digit_strings(row1, row2, row3)]
  end

  @row_length 27
  defp row_to_charlist(row) do
    row_to_charlist(row, String.length(row) == (@row_length+1) && String.last(row) == "\n")
  end
  defp row_to_charlist(row, true) do
    {:ok, row |> String.to_charlist |> Enum.take(@row_length)}
  end
  defp row_to_charlist(row, false) do
    {:error,  "Invalid row length for #{row}"}
  end
end

