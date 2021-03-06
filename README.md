# UK Postcode

[![Build Status](https://travis-ci.org/KushalP/uk_postcode.svg?branch=master)](https://travis-ci.org/KushalP/uk_postcode)
[![Hex Version](http://img.shields.io/hexpm/v/uk_postcode.svg?style=flat)](https://hex.pm/packages/uk_postcode)
[![Inline docs](http://inch-ci.org/github/KushalP/uk_postcode.svg?branch=master&style=flat)](http://inch-ci.org/github/KushalP/uk_postcode)

UK postcode parsing and validation for
[Elixir](http://elixir-lang.org/). Based on the excellent Ruby library
of the [same name](https://github.com/threedaymonk/uk_postcode) by
[@threedaymonk](https://github.com/threedaymonk).

## Usage

Validate full postcodes or parts of a postcode.

```elixir
UKPostcode.valid? "W1A 1AA" #=> true
UKPostcode.full? "W1A 1AA"  #=> true
UKPostcode.outcode? "W1A"   #=> true
```

Extract parts of a full postcode.

```elixir
UKPostcode.outcode "W1A 1AA" #=> "W1A"
UKPostcode.incode "W1A 1AA"  #=> "1AA"
```

Normalise badly formatted postcodes.

```elixir
UKPostcode.normalise "w1a1aa"  #=> "W1A 1AA"
```
