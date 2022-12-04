priorities =
  ?a..?z
  |> Enum.concat(?A..?Z)
  |> Enum.zip(1..52)
  |> Map.new()

bisect = fn xs ->
  half = length(xs) |> Integer.floor_div(2)
  Enum.split(xs, half)
end

input =
  'day03.txt'
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.map(&to_charlist/1)

part1 =
  input
  |> Enum.map(fn x -> bisect.(x) end)
  |> Enum.map(fn {l, r} -> { MapSet.new(l), MapSet.new(r) } end)
  |> Enum.map(fn {l, r} -> MapSet.intersection(l,r) end)
  |> Enum.map(fn m -> Enum.at(m, 0) end)
  |> Enum.map(fn x -> priorities[x] end) |> Enum.sum()

part2 =
  input
  |> Enum.map(&MapSet.new/1)
  |> Enum.chunk_every(3)
  |> Enum.map(fn xs -> Enum.reduce(xs, &MapSet.intersection/2) end)
  |> Enum.map(fn m -> Enum.at(m, 0) end)
  |> Enum.map(fn x -> priorities[x] end) |> Enum.sum()

IO.puts part1
IO.puts part2
