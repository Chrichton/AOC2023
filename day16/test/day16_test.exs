defmodule Day16Test do
  use ExUnit.Case
  doctest Day16

  test "read_input" do
    assert Day16.read_input("sample") ==
             {
               %{
                 {0, 1} => "|",
                 {1, 0} => "|",
                 {1, 7} => "-",
                 {1, 8} => "|",
                 {2, 1} => "-",
                 {2, 9} => "/",
                 {3, 7} => "-",
                 {3, 9} => "/",
                 {4, 1} => "\\",
                 {4, 6} => "/",
                 {4, 7} => "/",
                 {5, 0} => "\\",
                 {5, 2} => "|",
                 {5, 9} => "|",
                 {6, 2} => "-",
                 {6, 6} => "\\",
                 {6, 8} => "-",
                 {7, 6} => "\\",
                 {7, 7} => "|",
                 {7, 8} => "|",
                 {8, 3} => "|",
                 {9, 5} => "\\",
                 {9, 8} => "\\"
               },
               {9, 9}
             }
  end

  test "next_rays ." do
    assert Day16.next_rays({{0, 0}, :east}, Map.new(), 9, 9) == [{{1, 0}, :east}]
  end

  test "next_rays |" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "|"}]), 9, 9) ==
             [{{1, 1}, :south}]
  end

  test "next_rays -" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "-"}]), 9, 9) ==
             [{{2, 0}, :east}]
  end

  test "next_rays \\" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "\\"}]), 9, 9) ==
             [{{1, 1}, :south}]
  end

  test "next_rays /" do
    assert Day16.next_rays({{1, 0}, :west}, Map.new([{{1, 0}, "/"}]), 9, 9) ==
             [{{1, 1}, :south}]
  end

  test "sample" do
    assert Day16.solve("sample") == 46
  end

  test "star" do
    assert Day16.solve("star") == 8323
  end

  test "sample2" do
    assert Day16.solve2("sample") == 51
  end

  # 8536 too high
  @tag timeout: :infinity
  test "star2" do
    assert Day16.solve2("star") == 51
  end
end
