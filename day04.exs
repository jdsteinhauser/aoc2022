input =
  'day04.txt'
  |> File.read!()
  |> String.split(["\n", ",", "-"], trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_every(2)
  |> Enum.map(fn [x,y] -> MapSet.new(x..y) end)
  |> Enum.chunk_every(2)

part1 = Enum.count(input, fn [l,r] -> MapSet.intersection(l,r) == l || MapSet.intersection(l,r) == r end)

part2 = Enum.count(input, fn [l,r] -> MapSet.intersection(l,r) != MapSet.new() end)

IO.puts part1
IO.puts part2
