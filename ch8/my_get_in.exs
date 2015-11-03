defmodule MyGetIn do
  def my_get_in(data, [head]), do: Dict.get(data, head)
  def my_get_in(data, [head |tail]) when is_function(head) do
    head.(:get, data, fn (row) -> my_get_in(row, tail) end)
  end
  def my_get_in(data, [head | tail]) do
    my_get_in(Dict.get(data, head), tail)
  end
end
