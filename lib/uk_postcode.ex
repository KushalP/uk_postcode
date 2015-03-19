defmodule UKPostcode do
  @moduledoc false

  @re_outcode_only ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?))\Z/
  @re_full         ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?)) ?((?-mix:[0-9][ABD-HJLNP-UW-Z]{2}))\Z/

  def full?(postcode) do
    postcode |> strip_and_upcase =~ @re_full
  end

  def incode(postcode) do
    if full?(postcode) do
      [_, _, incode] = Regex.run(@re_full, postcode |> strip_and_upcase)
      {:ok, incode}
    else
      {:error, postcode, "input was not a valid full postcode"}
    end
  end

  def normalise(postcode) do
    case {outcode(postcode), incode(postcode)} do
      {{:ok, outcode}, {:ok, incode}} ->
        outcode <> " " <> incode
      _ ->
        {:error, postcode, "input was not a valid full postcode"}
    end
  end

  def outcode(postcode) do
    cond do
      full?(postcode) ->
        [_, outcode, _] = Regex.run(@re_full, postcode |> strip_and_upcase)
        {:ok, outcode}
      outcode?(postcode) ->
        [_, outcode] = Regex.run(@re_outcode_only, postcode |> strip_and_upcase)
        {:ok, outcode}
      true ->
        {:error, postcode, "input was not a valid full postcode"}
    end
  end

  def outcode?(postcode) do
    postcode |> strip_and_upcase =~ @re_outcode_only
  end

  def valid?(postcode) do
    outcode?(postcode) or full?(postcode)
  end

  @doc false
  defp strip_and_upcase(postcode) do
    postcode |> String.strip |> String.upcase
  end
end
