defmodule Prime do
	def span(from, to), do: _span(from, to, [])
  def _span(from, to, list) when from > to, do: Enum.reverse(list)
  def _span(from, to, list) do
    _span(from + 1, to, [from | list])
  end

  def prime?(n) do
    Enum.all?(span(2, round(n/2)), fn (x) -> rem(n, x) !=0 end)
  end

  def prime(n) do
    for x <- span(2,n), prime?(x), do: x
  end
end
