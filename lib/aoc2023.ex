defmodule Aoc2023 do
  def get_input_for_day(day) do
    HTTPoison.get!(
      "https://adventofcode.com/2023/day/#{day}/input",
      [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}]
    )
    |> Map.get(:body)
  end
end



