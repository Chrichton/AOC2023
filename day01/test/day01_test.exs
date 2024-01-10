defmodule Day01Test do
  use ExUnit.Case

  test "find_first_digit" do
    assert Day01.find_first_digit("hallo52as") == "5"
  end

  test "solve sample1" do
    assert Day01.solve1("sample1") == 142
  end

  test "solve star1" do
    assert Day01.solve1("star1") == 142
  end
end
