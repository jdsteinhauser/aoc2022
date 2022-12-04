elves =
  'day01.txt'
  |> File.read!()
  |> String.replace("\n\n", "\n0\n")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.chunk_by(fn x -> x== 0 end)
  |> Enum.reject(fn x -> x == [0] end)
  |> Enum.map(&Enum.sum/1)
  |> Enum.sort(:desc)

part1 = Enum.at(elves, 0)
part2 = Enum.take(elves, 3) |> Enum.sum()

IO.puts 'Part 1: #{part1}'
IO.puts 'Part 2: #{part2}'

