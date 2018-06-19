defmodule UKPostcode.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @github "https://github.com/KushalP/uk_postcode"

  def project do
    [app: :uk_postcode,
     description: description(),
     version: @version,
     elixir: "~> 1.0",
     deps: deps(),
     package: package(),
     docs: [readme: "README",
            source_ref: "v#{@version}",
            source_url: @github],
     source_url: @github,
     homepage_url: @github]
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
    [# Documentation dependencies
     {:earmark, "~> 1.2", only: :docs},
     {:ex_doc, "~> 0.18", only: :docs},
     {:inch_ex, "~> 0.5", only: :docs},

     # Test depdendencies
     {:ex_spec, "~> 2.0", only: :test}]
  end

  defp package do
    [contributors: ["Kushal Pisavadia"],
     licenses: ["MIT"],
     links: %{"GitHub" => @github}]
  end
end
