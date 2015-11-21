defprotocol Size do
  @fallback_to_any true
  def size(this)
end

defimpl Size, for: Tuple do
  def size(t), do: tuple_size(t)
end

defimpl Size, for: BitString do
  def size(bs), do: bit_size(bs)
end

defimpl Size, for: List do
  def size(list), do: length(list)
end

defimpl Size, for: Any do
  def size(%{__struct__: struct} = map) do
    pruned = :maps.remove(:__exception__, :maps.remove(:__struct__, map))
    map_size pruned
  end

  def size(x), do: Enum.count(x)
end

defmodule User do
	defstruct name: "", age: 30
end


defmodule Test do
  def test do
    [[1,2,3], "hello", {:a,:b,:c,:d}, <<1,2,3>>, %{a: 10} , %User{name: "dennis"}]
    |> Enum.each(fn x ->
      IO.puts "Size.size(#{inspect(x)}) = #{inspect(Size.size(x))}"
    end)
  end
end

Test.test
