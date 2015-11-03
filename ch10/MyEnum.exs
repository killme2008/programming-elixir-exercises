defmodule MyEnum do
  def all?(list, pred), do: _all?(list, pred, true)
  def _all?(_list, _pred, false), do: false
  def _all?([], _pred, true), do: true
  def _all?([head | tail], pred, true) do
    _all?(tail, pred, pred.(head))
  end

  def each([], _f), do: :ok
  def each([h | t], f) do
    f.(h)
    each(t, f)
  end

  def filter(list, pred), do: _filter(list, pred, [])
  def _filter([], _pred, ret), do: Enum.reverse(ret)
  def _filter([head | tail], pred, ret) do
    if(pred.(head)) do
      _filter(tail, pred, [head | ret])
    else
      _filter(tail, pred, ret)
    end
  end

  def split(list, c), do: _split(list, c, [])
  def _split([], _c, left), do: {Enum.reverse(left), []}
  def _split(list, 0, left), do: {Enum.reverse(left), list}
  def _split([head|tail], c, left) when c>0 do
    _split(tail, c-1, [head | left])
  end
  def _split(list, c, left) when c<0 do
    {l, r} = _split(Enum.reverse(list), -c, left)
    {Enum.reverse(r), Enum.reverse(l)}
  end

  def flattern(list), do: _flattern(list, [])
  def _flattern([], ret), do: Enum.reverse(ret)
  def _flattern([head | tail], ret) do
    if is_list(head) do
      _flattern(head ++ tail, ret)
    else
      _flattern(tail, [head | ret])
    end
  end
end
