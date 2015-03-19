defmodule UKPostcodeTest do
  use ExSpec, async: true

  @valid_samples ["A9 9AA", "A99 9AA", "AA9 9AA", "AA99 9AA", "A9A 9AA", "AA9A 9AA",
                  "SW1A 0AA", "SW1A 0PW", "SW1A 1AA", "SW1A 2HQ", "W1A 1AA", "W1A 1AB",
                  "N81 1ER", "EH99 1SP"]
  @valid_outcodes @valid_samples |>
    Stream.map(&(String.split(&1, " "))) |>
    Stream.map(&(hd(&1))) |>
    Enum.to_list
  @valid_incodes @valid_samples |>
    Stream.map(&(String.split(&1, " "))) |>
    Stream.map(&(tl(&1))) |>
    Enum.to_list |>
    List.flatten

  describe "#valid?" do
    it "shows empty strings as invalid postcodes" do
      Enum.map(["", " ", "\r\n", "\n"], &(refute UKPostcode.valid? &1))
    end

    it "full samples with spaces should all be valid" do
      Enum.map(@valid_samples, &(assert UKPostcode.valid? &1))
    end

    it "full samples without spaces should all be valid" do
      without_spaces = Enum.map(@valid_samples, &(String.replace(&1, " ", "")))
      Enum.map(without_spaces, &(assert UKPostcode.valid? &1))
    end

    it "outcodes should all be valid" do
      Enum.map(@valid_outcodes, &(assert UKPostcode.valid? &1))
    end

    it "lowercase postcode should be valid" do
      assert UKPostcode.valid? "w1a 1aa"
    end

    it "should not be valid if truncated" do
      refute UKPostcode.valid? "W1A 1A"
    end
  end

  describe "#full?" do
    it "full? only matches full postcode" do
      Enum.map(@valid_samples, &(assert UKPostcode.full? &1))
      Enum.map(@valid_outcodes, &(refute UKPostcode.full? &1))
    end
  end

  describe "#outcode?" do
    it "outcode? matches only outcodes of postcodes" do
      Enum.map(@valid_samples, &(refute UKPostcode.outcode? &1))
      Enum.map(@valid_outcodes, &(assert UKPostcode.outcode? &1))
    end
  end

  describe "#outcode" do
    it "can extract the outcode" do
      Enum.map(Enum.zip(@valid_outcodes, @valid_samples),
               &(assert {:ok, elem(&1, 0)} == UKPostcode.outcode(elem(&1, 1))))
      assert {:ok, "A9"} == UKPostcode.outcode("A9")
    end

    it "outcode returns the provided value and errors when a valid postcode isn't provided" do
      assert :error == elem(UKPostcode.outcode("FOO"), 0)
      assert "FOO"  == elem(UKPostcode.outcode("FOO"), 1)
    end
  end

  describe "#incode" do
    it "can extract the incode" do
      Enum.map(Enum.zip(@valid_incodes, @valid_samples),
               &(assert {:ok, elem(&1, 0)} == UKPostcode.incode(elem(&1, 1))))
    end

    it "incode returns the provided value and errors when a valid postcode isn't provided" do
      assert :error == elem(UKPostcode.incode("FOO"), 0)
      assert "FOO"  == elem(UKPostcode.incode("FOO"), 1)
    end
  end

  describe "#normalise" do
    it "can normalise a badly formatted postcode" do
      assert {:ok, "W1A 1AA"} == UKPostcode.normalise "W1A1AA"
      assert {:ok, "W1A 1AA"} == UKPostcode.normalise "w1a 1aa"
    end

    it "normalising using an invalid outcode or incode returns an error" do
      assert :error == elem(UKPostcode.normalise("FOO"), 0)
      assert "FOO"  == elem(UKPostcode.normalise("FOO"), 1)
    end
  end
end
