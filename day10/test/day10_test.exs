defmodule Day10Test do
  use ExUnit.Case

  test "read_input" do
    assert Day10.read_input("sample") ==
             {{1, 1},
              %{
                {1, 2} => "|",
                {1, 3} => "L",
                {2, 1} => "-",
                {2, 3} => "-",
                {3, 1} => "7",
                {3, 2} => "|",
                {3, 3} => "J"
              }}
  end
end
