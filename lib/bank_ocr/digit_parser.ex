defmodule BankOcr.DigitParser do
  @moduledoc """
  Parses digts from OCR formatted strings.
  """

  def parse_digit(["   ", "  |", "  |"]), do: 1
  def parse_digit([" _ ", " _|", "|_ "]), do: 2
end

