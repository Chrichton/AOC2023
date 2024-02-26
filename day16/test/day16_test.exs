defmodule Day16Test do
  use ExUnit.Case
  doctest Day16

  test "read_input" do
    assert Day16.read_input("sample") == %{
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
           }
  end

  test "next_rays ." do
    assert Day16.next_rays({{0, 0}, :east}, Map.new()) == [{{1, 0}, :east}]
  end

  test "next_rays |" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "|"}])) ==
             [{{1, 1}, :south}]
  end

  test "next_rays -" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "-"}])) ==
             [{{2, 0}, :east}]
  end

  test "next_rays \\" do
    assert Day16.next_rays({{1, 0}, :east}, Map.new([{{1, 0}, "\\"}])) ==
             [{{1, 1}, :south}]
  end

  test "next_rays /" do
    assert Day16.next_rays({{1, 0}, :west}, Map.new([{{1, 0}, "/"}])) ==
             [{{1, 1}, :south}]
  end
end
