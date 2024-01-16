defmodule Day03Test do
  use ExUnit.Case

  test "get_neighbors" do
    Day03.get_neighbors("467", {2, 0})
  end

  test "sample1" do
    assert Day03.solve("sample1") == 4361
  end

  test "star1" do
    assert Day03.solve("star") == 4361
  end
end
