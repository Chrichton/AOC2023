defmodule Day15Test do
  use ExUnit.Case

  test "hash" do
    assert Day15.hash("HASH") == 52
  end

  test "sample" do
    assert Day15.solve("sample") == 1320
  end

  test "star" do
    assert Day15.solve("star") == 513_214
  end
end
