defmodule BankOcr do
  @moduledoc """
  Documentation for BankOcr.
  """

  import BankOcr.AccountNumber

  @doc """
  argv should just be a filename to parse
  """
  def main(argv) do
    argv
    |> List.first
    |> File.stream!
    |> Enum.chunk_every(4)
    |> Enum.each(&print_number/1)
  end

  defp print_number(number_string) do
    number_string
    |> number_string_to_digit_strings
    |> digit_strings_to_digits
    |> format_for_display
    |> IO.puts
  end
end
