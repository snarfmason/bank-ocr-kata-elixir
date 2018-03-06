defmodule BankOcr.DigitParser do
  @moduledoc """
  Parses individual digts from OCR formatted partial strings.
  """

  def parse_digit(["   ", "  |", "  |"]), do: 1
  def parse_digit([" _ ", " _|", "|_ "]), do: 2
  def parse_digit([" _ ", " _|", " _|"]), do: 3
  def parse_digit(["   ", "|_|", "  |"]), do: 4
  def parse_digit([" _ ", "|_ ", " _|"]), do: 5
  def parse_digit([" _ ", "|_ ", "|_|"]), do: 6
  def parse_digit([" _ ", "  |", "  |"]), do: 7
  def parse_digit([" _ ", "|_|", "|_|"]), do: 8
  def parse_digit([" _ ", "|_|", " _|"]), do: 9
  def parse_digit([" _ ", "| |", "|_|"]), do: 0
  def parse_digit(_), do: nil
end

