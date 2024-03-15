defmodule Day18FloodTest do
  use ExUnit.Case

  test "shoelace" do
    assert Day18Flood.shoelace([{2, 7}, {10, 1}, {8, 6}, {11, 7}, {7, 10}]) == 32
  end

  test "sample" do
    assert Day18Flood.solve("sample") == 62
  end

  @tag timeout: :infinity
  test "star" do
    assert Day18Flood.solve("star") == 50746
  end
end
