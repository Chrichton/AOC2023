defmodule Day18FloodTest do
  use ExUnit.Case

  test "sample" do
    assert Day18Flood.solve("sample") == 62
  end

  @tag timeout: :infinity
  test "star" do
    assert Day18Flood.solve("star") == 62
  end
end
