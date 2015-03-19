# UK Postcode

[![Build Status](https://travis-ci.org/KushalP/uk_postcode.svg?branch=master)](https://travis-ci.org/KushalP/uk_postcode)

UK postcode parsing and validation for
[Elixir](http://elixir-lang.org/).

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
