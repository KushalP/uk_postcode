defmodule UKPostcode.Error do
  defexception [reason: nil, value: nil]

  def message(exception) do
    "#{exception.value}: #{exception.reason}"
  end
end
