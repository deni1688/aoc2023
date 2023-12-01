defmodule Aoc2023DayOne do
  def get_input do
    HTTPoison.get!(
      "https://adventofcode.com/2023/day/1/input",
      [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}]
    )
    |> Map.get(:body)
    |> String.split("\n")
    |> Enum.each(&IO.puts/1)
  end
end
