defmodule Day2 do
  def part1 do
    Aoc2023.get_input_for_day(2)
    |> get_games()
    |> sum_possible()
  end

  def part2 do
    Aoc2023.get_input_for_day(2)
    |> get_games()
    |> calc_min_required()
  end

  defp calc_min_required(games) do
    games
    |> Enum.map(&(List.flatten(&1) |> Enum.reject(fn it -> it == nil or it == [] end)))
    |> Enum.reject(&(&1 == []))
    |> Enum.reduce(0, fn game, acc -> 
        red = Enum.filter(game, fn it -> it.name == "red" end) |> get_max() 
        green = Enum.filter(game, fn it -> it.name == "green" end)  |> get_max() 
        blue = Enum.filter(game, fn it -> it.name == "blue" end)  |> get_max() 

        acc + (red * green * blue)
    end)
  end

  defp get_max(list) do
    list 
    |> Enum.max_by(fn it -> it.value end) |> Map.get(:value)
  end

  defp sum_possible(games) do
    games
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {game, index}, acc ->
      if Enum.all?(game, fn set -> Enum.all?(set, &is_possible/1) end) do
        acc + index
      else
        acc
      end
    end)
  end

  defp get_games(content) do
    content
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/Game \d+: /, ""))
    |> Enum.map(fn game ->
      game
      |> String.split("; ")
      |> Enum.map(&String.split(&1, ", "))
      |> Enum.reject(&(&1 == []))
      |> Enum.map(fn set ->
        set
        |> Enum.map(&String.split(&1, " "))
        |> Enum.map(fn it -> %{color: Enum.at(it, 1), value: Enum.at(it, 0)} end)
        |> Enum.reject(&(&1.value == ""))
        |> Enum.map(&%{name: &1.color, value: String.to_integer(&1.value)})
      end)
      |> Enum.reject(&(&1 == []))
    end)
    |> Enum.reject(&(&1 == []))
  end

  defp is_possible(%{name: "red", value: value}), do: value <= 12
  defp is_possible(%{name: "green", value: value}), do: value <= 13
  defp is_possible(%{name: "blue", value: value}), do: value <= 14
end
