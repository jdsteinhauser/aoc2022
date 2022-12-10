parse_instruction = fn line ->
  [_move, num, _from, from, _to, to] = String.split(line)

  %{
    num: String.to_integer(num),
    from: String.to_integer(from),
    to: String.to_integer(to)
  }
end

apply_instruction = fn %{num: num, from: from, to: to}, cargo ->
  movers =
    cargo[from]
    |> Enum.take(num)
    |> Enum.reverse()
  cargo
  |> Map.update!(from, fn x -> Enum.drop(x, num) end)
  |> Map.update!(to, fn x -> movers ++ x end)
end

apply_instruction2 = fn %{num: num, from: from, to: to}, cargo ->
  movers =
    cargo[from]
    |> Enum.take(num)
  cargo
  |> Map.update!(from, fn x -> Enum.drop(x, num) end)
  |> Map.update!(to, fn x -> movers ++ x end)
end

initial_state = %{
  1 => 'TQVCDSN',
  2 => 'VFM',
  3 => 'MHNPDWQF',
  4 => 'FTRQD',
  5 => 'BVHQNMFR',
  6 => 'QWPNGFC',
  7 => 'TCLRFW',
  8 => 'SNZT',
  9 => 'NHQRJDSM'
}

instructions =
    'day05.txt'
    |> File.read!()
    |> String.split("\n", trim: true)
    # Foregoing full parsing of stacks
    # |> Enum.split( fn x -> x == " 1   2   3   4   5   6   7   8   9 " end)
    |> Enum.drop(9)
    |> Enum.map(fn x -> parse_instruction.(x) end)


part1 =
  instructions
  |> Enum.reduce(initial_state, fn i, xs -> apply_instruction.(i, xs) end)
  |> Map.values()
  |> Enum.map(&hd/1)

part2 =
  instructions
  |> Enum.reduce(initial_state, fn i, xs -> apply_instruction2.(i, xs) end)
  |> Map.values()
  |> Enum.map(&hd/1)

IO.puts part1
IO.puts part2
