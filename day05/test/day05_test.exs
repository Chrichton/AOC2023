defmodule Day05Test do
  use ExUnit.Case

  test "read_input" do
    assert Day05.read_input("sample") ==
             {
               [79, 14, 55, 13],
               [
                 [[50, 98, 2], ~c"420"],
                 [[0, 15, 37], [37, 52, 2], [39, 0, 15]],
                 [~c"15\b", [0, 11, 42], [42, 0, 7], [57, 7, 4]],
                 [[88, 18, 7], [18, 25, 70]],
                 [[45, 77, 23], [81, 45, 19], ~c"D@\r"],
                 [[0, 69, 1], [1, 0, 69]],
                 [[60, 56, 37], [56, 93, 4]]
               ]
             }
  end

  test "sample1" do
    assert Day05.solve("sample") == 35
  end

  @tag timeout: :infinity
  test "star1" do
    assert Day05.solve("star") == nil
  end
end
