defmodule UKPostcode.Mixfile do
  use Mix.Project

  def project do
    [app: :uk_postcode,
     description: description,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps,
     package: package]
  end

  def application do
    []
  end

  defp description do
    """
    UK postcode parsing and validation library.

    Validate full postcodes or parts of a postcode, and can extract parts of a full postcode.
    """
  end

  defp deps do
    []
  end

  def package do
    [contributors: ["Kushal Pisavadia"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/KushalP/uk_postcode"}]
  end
end
