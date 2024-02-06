defmodule Day09Test do
  use ExUnit.Case

  test "sample" do
    assert Day09.solve("sample") == 114
  end

  test "star" do
    assert Day09.solve("star") == 1_901_217_887
  end

  test "sample2" do
    assert Day09.solve2("sample2") == 5
  end

  # test "star2" do
  #   assert Day09.solve2("star") == 5
  # end
end
