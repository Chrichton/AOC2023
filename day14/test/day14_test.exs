defmodule Day14Test do
  use ExUnit.Case

  test "read_input" do
    assert Day14.read_input("sample") == [
             ["O", ".", ".", ".", ".", "#", ".", ".", ".", "."],
             ["O", ".", "O", "O", "#", ".", ".", ".", ".", "#"],
             [".", ".", ".", ".", ".", "#", "#", ".", ".", "."],
             ["O", "O", ".", "#", "O", ".", ".", ".", ".", "O"],
             [".", "O", ".", ".", ".", ".", ".", "O", "#", "."],
             ["O", ".", "#", ".", ".", "O", ".", "#", ".", "#"],
             [".", ".", "O", ".", ".", "#", "O", ".", ".", "O"],
             [".", ".", ".", ".", ".", ".", ".", "O", ".", "."],
             ["#", ".", ".", ".", ".", "#", "#", "#", ".", "."],
             ["#", "O", "O", ".", ".", "#", ".", ".", ".", "."]
           ]
  end

  test "rotate_right" do
    assert Day14.rotate_right([
             ["O", ".", ".", ".", ".", "#", ".", ".", ".", "."],
             ["O", ".", "O", "O", "#", ".", ".", ".", ".", "#"],
             [".", ".", ".", ".", ".", "#", "#", ".", ".", "."],
             ["O", "O", ".", "#", "O", ".", ".", ".", ".", "O"],
             [".", "O", ".", ".", ".", ".", ".", "O", "#", "."],
             ["O", ".", "#", ".", ".", "O", ".", "#", ".", "#"],
             [".", ".", "O", ".", ".", "#", "O", ".", ".", "O"],
             [".", ".", ".", ".", ".", ".", ".", "O", ".", "."],
             ["#", ".", ".", ".", ".", "#", "#", "#", ".", "."],
             ["#", "O", "O", ".", ".", "#", ".", ".", ".", "."]
           ]) == [
             ["#", "#", ".", ".", "O", ".", "O", ".", "O", "O"],
             ["O", ".", ".", ".", ".", "O", "O", ".", ".", "."],
             ["O", ".", ".", "O", "#", ".", ".", ".", "O", "."],
             [".", ".", ".", ".", ".", ".", "#", ".", "O", "."],
             [".", ".", ".", ".", ".", ".", "O", ".", "#", "."],
             ["#", "#", ".", "#", "O", ".", ".", "#", ".", "#"],
             [".", "#", ".", "O", ".", ".", ".", "#", ".", "."],
             [".", "#", "O", ".", "#", "O", ".", ".", ".", "."],
             [".", ".", ".", ".", ".", "#", ".", ".", ".", "."],
             [".", ".", ".", "O", "#", ".", "O", ".", "#", "."]
           ]
  end

  test "move_os_right" do
    assert Day14.move_os_right(["O", ".", ".", "O", "#", ".", ".", ".", "O", "."]) ==
             [".", ".", "O", "O", "#", ".", ".", ".", ".", "O"]
  end

  test "calc_load" do
    assert Day14.calc_load(["#", "#", ".", ".", ".", ".", "O", "O", "O", "O"]) == 7 + 8 + 9 + 10
  end

  test "sample" do
    assert Day14.solve("sample") == 136
  end

  test "solve" do
    assert Day14.solve("star") == 109_098
  end

  test "sample2.1" do
    assert Day14.solve2("sample", 1) == 87
  end

  test "sample2.2" do
    assert Day14.solve2("sample", 2) == 69
  end

  test "sample2.3" do
    assert Day14.solve2("sample", 3) == 69
  end

  # repeating_cycle(starts(for 81))
  # test "find_repeating_cycle" do
  #   for max_cycle <- 75..100 do
  #     result = Day14.solve2("star", max_cycle)
  #     IO.puts("#{max_cycle}: #{result}")
  #   end
  # end

  test "calc_load_from_81_cycles_on" do
    assert Day14.calc_load_from_81_cycles_on(82) == 100_025
  end

  test "star2" do
    assert Day14.calc_load_from_81_cycles_on(1_000_000_000) == 100_064
  end
end
