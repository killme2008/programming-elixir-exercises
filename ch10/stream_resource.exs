Stream.resource(fn -> File.open!("sample") end,
  fn file ->
    case IO.read(file, :all) do
      "" -> {:halt, file}
      data when is_binary(data) ->
        {data |> String.rstrip
              |> String.split("\n"), file}
    end
  end,
  fn file -> File.close(file) end) |> Enum.to_list
