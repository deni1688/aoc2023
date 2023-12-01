defmodule Aoc2023DayOne do
  def get_input do
    session = System.get_env("AOC_SESSION")
    url = "https://adventofcode.com/2023/day/1/input"

    HTTPoison.get!(url, [{"cookie", "session=#{session}"}]) 
      |> Map.get(:body)
      |> String.split("\n") 
      |> Enum.each(&IO.puts/1)
  end
end
