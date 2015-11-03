defmodule Swap do
  def swap([]), do: []
  def swap([a, b | tail]) do
    [b, a | swap(tail)]
  end
  def swap([_]) do
    raise "Can't swap a list with an odd number of element."
  end
end
