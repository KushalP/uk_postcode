defmodule UKPostcode do
  @moduledoc """
  UK postcode parsing, validation and normalisation module.
  """

  @re_outcode_only ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?))\Z/
  @re_full         ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?)) ?((?-mix:[0-9][ABD-HJLNP-UW-Z]{2}))\Z/

  @doc ~S"""
  Returns true or false depending on if the value is a full valid postcode.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.full? "W1A 1AA"
      true
  """
  def full?(postcode) do
    postcode |> strip_and_upcase =~ @re_full
  end

  @doc ~S"""
  Extracts the right-hand part of the postcode.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.incode "W1A 1AA"
      {:ok, "1AA"}

  """
  def incode(postcode) do
    if full?(postcode) do
      [_, _, incode] = Regex.run(@re_full, postcode |> strip_and_upcase)
      {:ok, incode}
    else
      raise UKPostcode.Error, reason: "input was not a valid full postcode", value: postcode
    end
  end

  @doc ~S"""
  Returns the canonical string representation of the postcode.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.normalise "w1a1aa"
      {:ok, "W1A 1AA"}

  """
  def normalise(postcode) do
    case {outcode(postcode), incode(postcode)} do
      {{:ok, outcode}, {:ok, incode}} ->
        {:ok, "#{outcode} #{incode}"}
      _ ->
        raise UKPostcode.Error, reason: "input was not a valid full postcode", value: postcode
    end
  end

  @doc ~S"""
  Extracts the left-hand part of the postcode.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.outcode "W1A 1AA"
      {:ok, "W1A"}

  """
  def outcode(postcode) do
    cond do
      full?(postcode) ->
        [_, outcode, _] = Regex.run(@re_full, postcode |> strip_and_upcase)
        {:ok, outcode}
      outcode?(postcode) ->
        [_, outcode] = Regex.run(@re_outcode_only, postcode |> strip_and_upcase)
        {:ok, outcode}
      true ->
        raise UKPostcode.Error, reason: "input was not a valid full postcode", value: postcode
    end
  end

  @doc ~S"""
  Returns true or false depending on if the value is a valid left-hand
  value of a valid postcode.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.outcode? "W1A"
      true

  """
  def outcode?(postcode) do
    postcode |> strip_and_upcase =~ @re_outcode_only
  end

  @doc ~S"""
  Returns true or false depending on if the value is a valid postcode.
  This includes both full postcodes and outcode postcodes.

  postcode - String postcode

  ## Examples

      iex> UKPostcode.valid? "W1A 1AA"
      true

      iex> UKPostcode.valid? "W1A"
      true

  """
  def valid?(postcode) do
    outcode?(postcode) or full?(postcode)
  end

  @doc false
  defp strip_and_upcase(postcode) do
    postcode |> String.strip |> String.upcase
  end
end
