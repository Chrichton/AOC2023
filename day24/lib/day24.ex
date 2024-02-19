defmodule Day24 do
  def hailstorms(),
    do: [
      {{19, 13}, {-2, 1}},
      {{18, 19}, {-1, -1}},
      {{20, 25}, {-2, -2}},
      {{12, 31}, {-1, -2}},
      {{20, 19}, {1, -5}}
    ]

  def solve() do
    # Enum.map(
    #   [
    #     {{19, 13}, {-2, 1}},
    #     {{18, 19}, {-1, -1}}
    #   ],
    #   &time_tick/1
    # )

    time_tick({{20, 19}, {1, -5}})
  end

  @test_range 7..27

  def time_tick({{x, y}, {v_x, v_y}}) do
    {x_next, y_next} = {x + v_x, y + v_y}
    dx = if x_next > x, do: :x_inc, else: :x_dec
    dy = if y_next > x, do: :y_inc, else: :y_dec

    time_tick({x, y}, {dx, dy}, {v_x, v_y}, MapSet.new())
  end

  def time_tick({x, _y}, {:x_inc, _dy}, _v, path) when x > 27,
    do: path

  def time_tick({_x, y}, {_dx, :y_inc}, _v, path) when y > 27,
    do: path

  def time_tick({x, _y}, {:x_dec, _dy}, _v, path) when x < 7,
    do: path

  def time_tick({_x, y}, {_dx, :y_dec}, _v, path) when y < 7,
    do: path

  def time_tick({x, y}, slope, {v_x, v_y}, path) do
    path =
      if x in @test_range and y in @test_range,
        do: MapSet.put(path, {x, y}),
        else: path

    {x_next, y_next} = {x + v_x, y + v_y}
    time_tick({x_next, y_next}, slope, {v_x, v_y}, path)
  end
end
