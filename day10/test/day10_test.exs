defmodule Day10Test do
  use ExUnit.Case

  test "read_input" do
    assert Day10.read_input("sample") ==
             {
               {1, 1},
               %{
                 {1, 2} => [:north, :south],
                 {1, 3} => [:north, :east],
                 {2, 1} => [:east, :west],
                 {2, 3} => [:east, :west],
                 {3, 1} => [:south, :west],
                 {3, 2} => [:north, :south],
                 {3, 3} => [:north, :west],
                 {1, 1} => "S"
               }
             }
  end

  test "sample" do
    assert Day10.solve("sample") == 4
  end

  test "star" do
    assert Day10.solve("star") == 6942
  end
end
