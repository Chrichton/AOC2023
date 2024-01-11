defmodule Day01Test do
  use ExUnit.Case

  test "find_first_digit" do
    assert Day01.find_first_digit("hallo52as", false) == "5"
  end

  test "find_first_digit reverse" do
    assert Day01.find_first_digit("hallo52as", true) == "2"
  end

  test "solve sample1" do
    assert Day01.solve1("sample1") == 142
  end

  test "solve star1" do
    assert Day01.solve1("star1") == 54159
  end

  # Second star ----------------------------------------------

  test "solve sample2" do
    assert Day01.solve2("sample2") == 281
  end

  test "find_first_digit with text number" do
    assert Day01.find_first_digit("xtwone3four", false) == "2"
  end

  test "find_first_digit with text number revers" do
    assert Day01.find_first_digit("xtwone3four", true) == "4"
  end

  test "solve star2" do
    assert Day01.solve2("star1") == 53866
  end
end
