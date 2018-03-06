defmodule BankOcr.AccountNumber do
  @moduledoc """
  Parses digts from OCR formatted strings.
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

