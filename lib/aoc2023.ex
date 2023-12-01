defmodule Aoc2023 do
  def get_input_for_day(day) do
    HTTPoison.get!(
      "https://adventofcode.com/2023/day/#{day}/input",
      [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}]
    )
    |> Map.get(:body)
    |> String.split("\n")
    |> Enum.map(&Regex.replace(~r/[^0-9]/, &1, ""))
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(
      &if String.length(&1) > 1 do
        String.to_integer("#{String.at(&1, 0) || ""}#{String.at(&1, -1) || ""}")
      else
        String.to_integer(&1)
      end
    )
    |> Enum.sum()
  end

  defmodule Day1 do
    def part1 do
      Aoc2023.get_input_for_day(1)
    end
  end
end
