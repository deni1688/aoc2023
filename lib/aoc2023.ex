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
      |> Enum.map(fn x -> String.at(x, 0) <> String.at(x, -1) end)
      |> Enum.reject(&(String.length(&1) == 1))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end
  end
end
