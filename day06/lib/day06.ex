defmodule Day06 do
  def solve2 do
    time = 48_989_083
    max_distance = 390_110_311_121_360
    half_time = div(time, 2)

    find_winning_distances(half_time..2, time, max_distance)

    # find_winning_distances(half_time..time, time, max_distance)
  end

  def find_winning_distances(time_range, time, max_distance) do
    Enum.reduce_while(time_range, [], fn velocity, acc ->
      distance = distance(velocity, time)

      if distance > max_distance,
        do: {:cont, [distance | acc]},
        else: {:halt, acc}
    end)
  end

  def solve(input) do
    input
    |> read_input()
    |> calc_velocities_distances()
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(1, fn count, acc -> count * acc end)
  end

  def read_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> then(fn [time_str, distance_str] ->
      time_str
      |> String.split(":")
      |> calc_value_str()
      |> Enum.zip(
        distance_str
        |> String.split(":")
        |> calc_value_str()
      )
    end)
  end

  def calc_velocities_distances(races) do
    Enum.map(races, fn {race_time, winning_distance} ->
      Enum.reduce(1..(race_time - 1), [], fn time, acc ->
        distance = distance(time, race_time)

        if distance > winning_distance,
          do: [distance | acc],
          else: acc
      end)
    end)
  end

  def calc_value_str([_, value_str]) do
    value_str
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def distance(velocity, time), do: velocity * (time - velocity)
end
