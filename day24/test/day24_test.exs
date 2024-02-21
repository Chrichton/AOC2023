defmodule Day24Test do
  use ExUnit.Case

  test "read_input" do
    assert Day24.read_input("sample") == [
             [{19, 13, 30}, {-2, 1, -2}],
             [{18, 19, 22}, {-1, -1, -2}],
             [{20, 25, 34}, {-2, -2, -4}],
             [{12, 31, 28}, {-1, -2, -1}],
             [{20, 19, 15}, {1, -5, -3}]
           ]
  end

  test "sample" do
    assert Day24.solve("sample", {7, 27}) == 2
  end

  test "star" do
    assert Day24.solve("star", {200_000_000_000_000, 400_000_000_000_000}) == 27732
  end

  test "sample usage" do
    # Example usage
    # Direction vector of line 1
    v1 = {-2, 1, 0}
    # Direction vector of line 2
    v2 = {-1, -1, 0}
    # Point on line 1
    p1 = {19, 13, 0}
    # Point on line 2
    p2 = {18, 19, 0}

    intersection_point = Day24.find_intersection_point([[p1, v1], [p2, v2]])
    # Output: {14.333, y=15.333}
    IO.inspect(intersection_point)
  end

  # test "sample" do
  #   # Example usage
  #   # Direction vector of line 1
  #   v1 = {-2, 1}
  #   # Direction vector of line 2
  #   v2 = {-1, -1}
  #   # Point on line 1
  #   p1 = {19, 13}
  #   # Point on line 2
  #   p2 = {18, 19}

  #   intersection_point = Day24.find_intersection_point(v1, v2, p1, p2)
  #   # Output: {14.333, y=15.333}
  #   IO.inspect(intersection_point)
  # end

  # test "sample" do
  #   # Example usage
  #   # Direction vector of line 1
  #   v1 = {-2, 1}
  #   # Direction vector of line 2
  #   v2 = {-2, -2}
  #   # Point on line 1
  #   p1 = {19, 13}
  #   # Point on line 2
  #   p2 = {12, 31}

  #   intersection_point = Day24.find_intersection_point(v1, v2, p1, p2)
  #   # Output: {14.333, y=15.333}
  #   IO.inspect(intersection_point)
  # end

  # test "sample" do
  #   # Example usage
  #   # Direction vector of line 1
  #   v1 = {1, 1}
  #   # Direction vector of line 2
  #   v2 = {1, 0}
  #   # Point on line 1
  #   p1 = {1, 3}
  #   # Point on line 2
  #   p2 = {5, 7}

  #   intersection_point = Day24.find_intersection_point(v1, v2, p1, p2)
  #   # Output: {14.333, y=15.333}
  #   IO.inspect(intersection_point)
  # end

  # test "sample" do
  #   # Example usage
  #   # Direction vector of line 1
  #   v1 = {3, 5}
  #   # Direction vector of line 2
  #   v2 = {-7, 0}
  #   # Point on line 1
  #   p1 = {1, 15}
  #   # Point on line 2
  #   p2 = {14, 26}

  #   intersection_point = Day24.find_intersection_point(v1, v2, p1, p2)
  #   # Output: {14.2.200000047683716, y=0.9142857789993286.333}
  #   IO.inspect(intersection_point)
  # end
end
