defmodule User do
	defstruct username: "", age: 33
end

defimpl Inspect, for: Any do
  def inspect(%{__struct__: struct} = map, opts) do
    try do
      struct.__struct__
    rescue
      _ -> Inspect.Map.inspect(map, opts)
    else
      dunder ->
      if :maps.keys(dunder) == :maps.keys(map) do
        pruned = :maps.remove(:__exception__, :maps.remove(:__struct__, map))
        Inspect.Map.inspect(pruned, Inspect.Atom.inspect(struct, opts), opts)
      else
        Inspect.Map.inspect(map, opts)
      end
    end
  end
end
defmodule Test do
  user = %User{username: "dennis"}
  IO.puts inspect(user)
end
