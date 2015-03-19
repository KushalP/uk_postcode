defmodule UKPostcodeTest do
  use ExUnit.Case, async: true

  @valid_samples ["A9 9AA", "A99 9AA", "AA9 9AA", "AA99 9AA", "A9A 9AA", "AA9A 9AA",
                  "SW1A 0AA", "SW1A 0PW", "SW1A 1AA", "SW1A 2HQ", "W1A 1AA", "W1A 1AB",
                  "N81 1ER", "EH99 1SP"]
  @valid_outcodes @valid_samples |>
    Stream.map(&(String.split(&1, " "))) |>
    Stream.map(&(hd(&1))) |>
    Enum.to_list
  @valid_incodes @valid_samples |>
    Stream.map(&(String.split(&1, " "))) |>
    Stream.map(&(tl(&1))) |>
    Enum.to_list

  test "empty strings aren't valid postcodes" do
    Enum.map(["", " ", "\r\n", "\n"], &(refute UKPostcode.valid? &1))
  end

  test "full samples with spaces should all be valid" do
    Enum.map(@valid_samples, &(assert UKPostcode.valid? &1))
  end

  test "full samples without spaces should all be valid" do
    without_spaces = Enum.map(@valid_samples, &(String.replace(&1, " ", "")))
    Enum.map(without_spaces, &(assert UKPostcode.valid? &1))
  end

  test "outcodes should all be valid" do
    Enum.map(@valid_outcodes, &(assert UKPostcode.valid? &1))
  end

  test "lowercase postcode should be valid" do
    assert UKPostcode.valid? "w1a 1aa"
  end
end
