defmodule Aoc2023 do
  def get_input_for_day(day) do
    HTTPoison.get!(
      "https://adventofcode.com/2023/day/#{day}/input",
      [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}]
    )
    |> Map.get(:body)
  end

  defmodule Day1 do
    def part1 do
      Aoc2023.get_input_for_day(1)
      |> String.split("\n")
      |> Enum.map(&Regex.replace(~r/\D/, &1, ""))
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&(String.at(&1, 0) <> String.at(&1, -1)))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end

    def part2 do
      Aoc2023.get_input_for_day(1)
      |> String.split("\n")
      |> Enum.map(fn x ->
        Regex.scan(~r/(?=(one|two|three|four|five|six|seven|eight|nine))|\d+/, x)
        |> List.flatten()
        |> Enum.map(
          &case &1 do
            "one" -> "1"
            "two" -> "2"
            "three" -> "3"
            "four" -> "4"
            "five" -> "5"
            "six" -> "6"
            "seven" -> "7"
            "eight" -> "8"
            "nine" -> "9"
            _ -> &1
          end
        )
        |> Enum.join()
      end)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&(String.at(&1, 0) <> String.at(&1, -1)))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end
  end

  defmodule Day2 do
    def part1 do
      Aoc2023.get_input_for_day(2)
      |> get_games()
      |> get_possible_scores()
    end

    defp get_possible_scores(games) do
      games
      |> Enum.with_index(1)
      |> Enum.reduce(0, fn {game, index}, acc ->
        if Enum.all?(game, fn set -> Enum.all?(set, &is_possible/1) end),
          do: acc + index,
          else: acc
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
end
