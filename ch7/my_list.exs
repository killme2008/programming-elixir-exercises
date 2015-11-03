defmodule MyList do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def reduce([], ret, _f), do: ret
  def reduce([head|tail], ret, f) do
    reduce(tail, f.(head, ret), f)
  end

  def map(list, f), do: _map(list, f, [])
  defp _map([], _f, ret) do
    :lists.reverse(ret)
  end
  defp _map([head | tail], f, ret) do
    _map(tail, f, [f.(head) | ret])
  end

  def filter(list, p), do: _filter(list, p, [])

  defp _filter([], _p, ret), do: :lists.reverse(ret)
  defp _filter([head | tail], p, ret) do
    if p.(head) do
      _filter(tail, p, [head | ret])
    else
      _filter(tail, p, ret)
    end
  end

  def max([]), do: nil
  def max([head | tail]), do: do_max(tail, head)

  defp do_max([], c), do: c
  defp do_max([head | tail], c) when head>c, do: do_max(tail, head)
  defp do_max([_head | tail], c), do: do_max(tail, c)

  def mapsum(list, f) do
    Enum.reduce(Enum.map(list, f), 0, &+/2)
  end

  def span(to, to) do
    [to]
  end
  def span(from, to) do
    [from | span((from + 1), to)]
  end
end
