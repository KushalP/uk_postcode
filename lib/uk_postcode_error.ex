defmodule UKPostcode.Error do
  @doc "Defines the UKPostcode exception format"
  defexception [reason: nil, value: nil]

  @doc """
  Converts a UKPostcode.Error into a String

  exception - A UKPostcode.Error exception
  """
  def message(exception) do
    "#{exception.value}: #{exception.reason}"
  end
end
