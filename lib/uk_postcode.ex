defmodule UKPostcode do
  @re_outcode_only ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?))\Z/
  @re_full         ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?)) ?((?-mix:[0-9][ABD-HJLNP-UW-Z]{2}))\Z/

  def full?(postcode) do
    postcode |> strip_and_upcase =~ @re_full
  end

  def outcode?(postcode) do
    postcode |> strip_and_upcase =~ @re_outcode_only
  end

  def valid?(postcode) do
    outcode?(postcode) or full?(postcode)
  end

  def strip_and_upcase(postcode) do
    postcode |> String.strip |> String.upcase
  end
end
