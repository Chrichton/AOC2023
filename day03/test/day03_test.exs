defmodule Day03Test do
  use ExUnit.Case

  test "sample1" do
    Day03.solve("sample1")
    |> IO.inspect()

    # assert Day03.solve("sample1") == 4361
  end
end
