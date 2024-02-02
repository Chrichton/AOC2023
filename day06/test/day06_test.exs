defmodule Day06Test do
  use ExUnit.Case

  test "sample1" do
    assert Day06.solve("sample1") == 288
  end

  test "star1" do
    assert Day06.solve("star1") == 4_568_778
  end

  test "sample2" do
    assert Day06.solve("sample2") == 71503
  end

  test "star2" do
    assert Day06.solve("star2") == 28_973_936
  end
end
