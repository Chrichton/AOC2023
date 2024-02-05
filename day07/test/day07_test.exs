defmodule Day07Test do
  use ExUnit.Case

  test "sample" do
    assert Day07.solve("sample", :star1) == 6440
  end

  test "star1" do
    assert Day07.solve("star", :star1) == 247_961_593
  end

  test "sample2" do
    assert Day07.solve("sample", :star2) == 5905
  end

  test "star2" do
    assert Day07.solve("star", :star2) == 248_750_699
  end
end
