defmodule Day24Test do
  use ExUnit.Case

  test "sample" do
    assert Day24.solve() == nil

    [m1, m2] = Day24.solve()
    MapSet.intersection(m1, m2)

    assert [m1, m2] == nil
    assert MapSet.intersection(m1, m2) == nil
  end
end
