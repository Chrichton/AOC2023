defmodule Day02 do
  def solve1(filename) do
    filename
    |> read_input()
    |> check_cube_sets(%{"red" => 12, "green" => 13, "blue" => 14})
    |> Enum.filter(fn {_, possible} -> possible end)
    |> Enum.map(fn {game_no, _} -> game_no end)
    |> Enum.sum()
  end

  def check_cube_sets(games_and_cubesets, bag_of_cubes = %{}) do
    games_and_cubesets
    |> Enum.map(fn {game_no, cube_set} ->
      {game_no, bag_of_cubes}
      {game_no, possible?(cube_set, bag_of_cubes)}
    end)
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [game, cube_sets_string] =
        String.split(line, ": ", trim: true)

      [_, game_no_string] = String.split(game, " ")

      {String.to_integer(game_no_string), parse(cube_sets_string)}
    end)
  end

  def parse(cube_sets_string) do
    String.split(cube_sets_string, "; ", trim: true)
    |> Enum.map(fn cube_set ->
      String.split(cube_set, ", ", trim: true)
      |> Map.new(fn cube ->
        [count_string, color] = String.split(cube, " ")
        {color, String.to_integer(count_string)}
      end)
    end)
  end

  def possible?(cube_sets, bag_of_cubes = %{}) when is_list(cube_sets) do
    cube_sets
    |> Enum.reduce_while(true, fn cube_set, acc ->
      if possible?(cube_set, bag_of_cubes),
        do: {:cont, acc},
        else: {:halt, false}
    end)
  end

  def possible?(cube_set = %{}, bag_of_cubes = %{}) do
    Map.keys(cube_set)
    |> Enum.reduce_while(true, fn cube_color, acc ->
      cube_color_count = Map.get(cube_set, cube_color)
      bag_color_count = Map.get(bag_of_cubes, cube_color)

      if bag_color_count != nil and cube_color_count <= bag_color_count,
        do: {:cont, acc},
        else: {:halt, false}
    end)
  end
end
