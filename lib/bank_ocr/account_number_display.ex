defmodule BankOcr.AccountNumberDisplay do
  @moduledoc """
  Formats account numbers for display. Account numbers should have been parsed by AccountNumber
  """

  import BankOcr.AccountNumber, only: [checksum: 1]

  @doc """
  Format a list of digits for display. digits should be a length 9 list of digits.
  """
  def format_for_display(digits), do: format_for_display(digits, valid(digits))

  defp format_for_display(digits, true) do
    "#{Enum.join(digits, "")}#{failed_checksum_suffix(checksum(digits))}"
  end
  defp format_for_display(digits, false) do
    partial_number = digits |> display_nils |> Enum.join("")
    "#{partial_number} ILL"
  end

  # Valid if there are no nils, so finding nil should return index nil (not in the list)
  defp valid(digits), do: Enum.find_index(digits, &(&1 == nil)) == nil

  defp failed_checksum_suffix(true), do: ""
  defp failed_checksum_suffix(false), do: " ERR"

  defp display_nils([]), do: []
  defp display_nils([nil | digits]), do: ['?' | display_nils(digits)]
  defp display_nils([d | digits]), do: [d | display_nils(digits)]
end
