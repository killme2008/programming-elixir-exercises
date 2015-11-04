defmodule Parse do
  def number([?+ | tail]), do:  number(tail)
  def number([?- | tail]), do:  number(tail) * -1
  def number(str), do: _number(str, 0)

  defp _number([], ret), do: ret
  defp _number([digit | tail], ret) when digit in '0123456789' do
    _number(tail, ret * 10 + (digit - ?0))
  end
  defp _number([non_digit|_], _), do: raise "Invalid digit '#{[non_digit]}'."
end
