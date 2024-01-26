defmodule Day04Test do
  use ExUnit.Case

  test "read_input" do
    [{winning_numbers1, my_numbers1} | _rest] = Day04.read_input("sample")

    assert winning_numbers1 == MapSet.new([41, 48, 83, 86, 17])
    assert my_numbers1 == MapSet.new([83, 86, 6, 31, 17, 9, 48, 53])
  end

  test "sample1" do
    assert Day04.solve1("sample") == 13
  end

  test "star1" do
    assert Day04.solve1("star") == 20855
  end

  test "create_card_count_map" do
    assert Day04.create_card_count_map(4) == %{1 => 1, 2 => 1, 3 => 1, 4 => 1}
  end

  test "update_card_counts" do
    assert Day04.increment_card_counts(%{3 => 1}, 2..4, 3) ==
             %{2 => 3, 3 => 4, 4 => 3}
  end

  test "sample2" do
    assert Day04.solve2("sample") == 30
  end

  test "star2" do
    assert Day04.solve2("star") == 5_489_600
  end
end
