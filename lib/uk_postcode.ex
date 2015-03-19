defmodule UKPostcode do
  @re_outcode_only ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?))\Z/
  @re_full         ~r/\A((?-mix:[A-Z]{1,2}[0-9R][0-9A-Z]?)) ?((?-mix:[0-9][ABD-HJLNP-UW-Z]{2}))\Z/

  def valid?(postcode) do
    adjusted_postcode = postcode |>
      String.strip |>
      String.upcase

    case adjusted_postcode do
      "" ->
        false
      _ ->
        Regex.match?(@re_outcode_only, adjusted_postcode) or
        Regex.match?(@re_full, adjusted_postcode)
    end
  end
end
