defmodule Day11Test do
  use ExUnit.Case

  test "sample twice as large" do
    assert Day11.solve("sample", 2) == 374
  end

  test "star twice as large" do
    assert Day11.solve("star", 2) == 9_799_681
  end

  test "sample 10 times larger" do
    assert Day11.solve("sample", 10) == 1030
  end

  test "sample 100 times larger" do
    assert Day11.solve("sample", 100) == 8410
  end

  test "star2 1000000 times larger" do
    assert Day11.solve("star", 1_000_000) == 513_171_773_355
  end
end
