input =
  'day06.txt'
  |> File.read!()
  |> to_charlist()

part1 =
  input
  |> Stream.chunk_every(4, 1)
  |> Stream.with_index(4)
  |> Enum.find(fn {xs, _} -> Enum.count(MapSet.new(xs)) == 4 end)
  |> elem(1)

IO.inspect(part1)

part2 =
  input
  |> Stream.chunk_every(14, 1)
  |> Stream.with_index(14)
  |> Stream.drop(part1)
  |> Enum.find(fn {xs, _} -> Enum.count(MapSet.new(xs)) == 14 end)
  |> elem(1)

IO.inspect(part2)
