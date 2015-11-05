ok! = fn (x) ->
  case x do
    {:ok, data} -> data
    _ -> raise "#{inspect(x)}"
  end
end
