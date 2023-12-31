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
