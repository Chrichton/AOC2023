defmodule Day02Test do
  use ExUnit.Case

  test "sample1" do
    assert Day02.solve1("sample1") == 8
  end

  test "star1" do
    assert Day02.solve1("star") == 0
  end
end
