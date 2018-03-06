defmodule BankOcr.DigitParserTest do
  use ExUnit.Case

  import BankOcr.DigitParser

  test "parses 1" do
    digit = ["   ",
             "  |",
             "  |"]
    assert parse_digit(digit) == 1
  end

  test "parses 2" do
    digit = [" _ ",
             " _|",
             "|_ "]
    assert parse_digit(digit) == 2
  end

  test "parses 3" do
    digit = [" _ ",
             " _|",
             " _|"]
    assert parse_digit(digit) == 3
  end

  test "parses 4" do
    digit = ["   ",
             "|_|",
             "  |"]
    assert parse_digit(digit) == 4
  end

  test "parses 5" do
    digit = [" _ ",
             "|_ ",
             " _|"]
    assert parse_digit(digit) == 5
  end

  test "parses 6" do
    digit = [" _ ",
             "|_ ",
             "|_|"]
    assert parse_digit(digit) == 6
  end

  test "parses 7" do
    digit = [" _ ",
             "  |",
             "  |"]
    assert parse_digit(digit) == 7
  end

  test "parses 8" do
    digit = [" _ ",
             "|_|",
             "|_|"]
    assert parse_digit(digit) == 8
  end

  test "parses 9" do
    digit = [" _ ",
             "|_|",
             " _|"]
    assert parse_digit(digit) == 9
  end

  test "parses 0" do
    digit = [" _ ",
             "| |",
             "|_|"]
    assert parse_digit(digit) == 0
  end
end
