defmodule Day03Test do
  use ExUnit.Case

  test "get_neighbors" do
    Day03.get_neighbors("467", {2, 0})
  end

  test "sample1" do
    assert Day03.solve("sample1") == 4361
  end

  test "star1" do
    assert Day03.solve("star") == 539_433
  end

  test "sample1 2nd" do
    assert Day03.solve2("sample1") == 467_835
  end

  test "2nd star" do
    assert Day03.solve2("star") == 75_847_567
  end
end
