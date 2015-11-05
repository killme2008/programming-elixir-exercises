defmodule Calculate do
	def calculate(exp), do: _eval(_parse(exp, [0]))

  defp _parse([], list), do: list
  defp _parse([digit | tail], list) when digit in '0123456789' do
    n = List.last(list)
    new_n = n * 10 + (digit - ?0)
    _parse(tail, List.replace_at(list, -1, new_n))
  end
  defp _parse([op,digit| tail], list) when op in '+-*/' and digit in '0123456789' do
    _parse([digit | tail], list ++ [op, 0])
  end
  defp _parse([invalid_char|_], _), do: raise "Inavlid char '#{[invalid_char]}'"

  defp _eval([n]), do: n
  defp _eval([n1,?+,n2 | tail]) do
    _eval([n1 + n2 |tail])
  end
  defp _eval([n1,?-,n2 | tail]) do
    _eval([n1 - n2 |tail])
  end
  defp _eval([n1,?*,n2 | tail]) do
    _eval([n1 * n2 |tail])
  end
  defp _eval([n1,?/,n2 | tail]) do
    _eval([n1 / n2 |tail])
  end
  defp _eval(list), do: raise "Can't eval '#{list}'"

end
