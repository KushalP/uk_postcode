defmodule UKPostcode.Mixfile do
  use Mix.Project

  @version "0.2.0"
  @github "https://github.com/KushalP/uk_postcode"

  def project do
    [app: :uk_postcode,
     description: description,
     version: @version,
     elixir: "~> 1.0",
     deps: deps,
     package: package,
     docs: [readme: true,
            main: "README",
            source_ref: "v#{@version}",
            source_url: @github]]
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
    [{:ex_spec, "~> 0.3.0", only: :test},
     {:inch_ex, only: :docs}]
  end

  defp package do
    [contributors: ["Kushal Pisavadia"],
     licenses: ["MIT"],
     links: %{"GitHub" => @github}]
  end
end
