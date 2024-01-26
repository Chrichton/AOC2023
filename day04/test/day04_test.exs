defmodule Day04Test do
  use ExUnit.Case

  test "read_input" do
    [{winning_numbers1, my_numbers1} | _rest] = Day04.read_input("sample")

    assert winning_numbers1 == MapSet.new([41, 48, 83, 86, 17])
    assert my_numbers1 == MapSet.new([83, 86, 6, 31, 17, 9, 48, 53])
 end

  test "sample" do
    assert Day04.solve1("sample") == 13
  end

  test "star" do
    assert Day04.solve1("star") == 20855
  end
end
