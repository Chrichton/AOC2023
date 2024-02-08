defmodule Day11Test do
  use ExUnit.Case

  test "sample" do
    assert Day11.solve("sample") == 374
  end

  test "star" do
    assert Day11.solve("star") == 9_799_681
  end
end
