defmodule Hex do
	def to_hex(n) do
    hex_strs = %{10 => "A", 11 => "B", 12 => "C",
                 13 => "D", 14 => "E", 15 => "F"}
    n
    |> digits(16)
    |> Enum.map(fn d ->
      Map.get hex_strs, d, d
    end)
    |> Enum.join
  end
  def digits(n, base \\ 10) when is_integer(n)    and n >= 0
  and  is_integer(base) and base >= 2 do
    do_digits(n, base, [])
  end

  defp do_digits(0, _base, []),  do: [0]
  defp do_digits(0, _base, acc), do: acc
  defp do_digits(n, base, acc)  do
    do_digits div(n, base), base, [rem(n, base) | acc]
  end

  def hex_to_string(hex) do
    {s, _} = :lists.foldr(fn
      (e, {acc, :nolow}) -> { acc, dehex(e) }
      (e, {acc, lo}) -> {[dehex(e) * 16 + lo | acc], :nolow}
    end, {[], :nolow}, String.to_char_list(hex))
    s |> Enum.reverse |> List.to_string
  end

  def dehex(h) when h >= ?a do
    h - ?a + 10
  end

  def dehex(h) when h >= ?A do
    h - ?A + 10
  end

  def dehex(h), do: h - ?0
end
