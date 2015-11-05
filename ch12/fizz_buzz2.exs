defmodule FizzBuzz2 do
  def upto(n) do
    Enum.map 1..n, &fizzbuzz/1
  end

  def fizzbuzz(x) do
    case {rem(x, 3), rem(x, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _ -> x
    end
  end
end
