defmodule Day02Test do
  use ExUnit.Case

  test "sample1" do
    assert Day02.solve1("sample1") == 8
  end

  test "star1" do
    assert Day02.solve1("star") == 2317
  end

  test "sample2" do
    assert Day02.solve2("sample1") == 2286
  end

  test "star2" do
    assert Day02.solve2("star") == 74804
  end
end
