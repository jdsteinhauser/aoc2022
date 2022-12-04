map_chars = %{
  ?A => :rock,
  ?B => :paper,
  ?C => :scissors,
  ?X => :rock,
  ?Y => :paper,
  ?Z => :scissors
}

map_outcome = %{
  ?X => :lose,
  ?Y => :draw,
  ?Z => :win
}

values = %{
  rock: %{points: 1, wins: :scissors, loses: :paper},
  paper: %{points: 2, wins: :rock, loses: :scissors},
  scissors: %{points: 3, wins: :paper, loses: :rock}
}

split_p1 = fn [x,_,y] -> { map_chars[x], map_chars[y] } end

result_p1 = fn
  {x, x} -> 3 + values[x].points
  {:rock, :paper} -> 6 + values.paper.points
  {:paper, :scissors} -> 6 + values.scissors.points
  {:scissors, :rock} -> 6 + values.rock.points
  {_, x} -> values[x].points
end

split_p2 = fn [x,_,y] -> { map_chars[x], map_outcome[y] } end

result_p2 = fn
  {x, :lose} -> values[values[x].wins].points
  {x, :win} -> 6 + values[values[x].loses].points
  {x, _} -> 3 + values[x].points
end

input =
  'day02.txt'
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_charlist/1)

  part1 =
    input
    |> Enum.map(fn x -> split_p1.(x) end)
    |> Enum.map(fn x -> result_p1.(x) end)
    |> Enum.sum()

  part2 =
    input
    |> Enum.map(fn x -> split_p2.(x) end)
    |> Enum.map(fn x -> result_p2.(x) end)
    |> Enum.sum()

IO.puts(part1)
IO.puts(part2)
