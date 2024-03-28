defmodule Day18FloodTest do
  use ExUnit.Case

  test "read_input" do
    assert Day18Flood.read_input("sample") == [
             %Day18Flood.Command{direction: "R", distance: 6, color_code: "70c710"},
             %Day18Flood.Command{direction: "D", distance: 5, color_code: "0dc571"},
             %Day18Flood.Command{direction: "L", distance: 2, color_code: "5713f0"},
             %Day18Flood.Command{direction: "D", distance: 2, color_code: "d2c081"},
             %Day18Flood.Command{direction: "R", distance: 2, color_code: "59c680"},
             %Day18Flood.Command{direction: "D", distance: 2, color_code: "411b91"},
             %Day18Flood.Command{direction: "L", distance: 5, color_code: "8ceee2"},
             %Day18Flood.Command{direction: "U", distance: 2, color_code: "caa173"},
             %Day18Flood.Command{direction: "L", distance: 1, color_code: "1b58a2"},
             %Day18Flood.Command{direction: "U", distance: 2, color_code: "caa171"},
             %Day18Flood.Command{direction: "R", distance: 2, color_code: "7807d2"},
             %Day18Flood.Command{direction: "U", distance: 3, color_code: "a77fa3"},
             %Day18Flood.Command{direction: "L", distance: 2, color_code: "015232"},
             %Day18Flood.Command{direction: "U", distance: 2, color_code: "7a21e3"}
           ]
  end

  test "shoelace" do
    assert Day18Flood.shoelace([{2, 7}, {10, 1}, {8, 6}, {11, 7}, {7, 10}]) == 32
  end

  test "sample" do
    assert Day18Flood.solve("sample", &Day18Flood.read_input/1) == 62
  end

  test "star" do
    assert Day18Flood.solve("star", &Day18Flood.read_input/1) == 50746
  end

  test "parse_color_code" do
    assert Day18Flood.parse_color_code("70c710") == {"R", 461_937}
  end

  test "sample2" do
    assert Day18Flood.solve("sample", &Day18Flood.read_input2/1) == 952_408_144_115
  end

  # 70086134643475 too low
  test "star2" do
    assert Day18Flood.solve("star", &Day18Flood.read_input2/1) == 0
  end
end
