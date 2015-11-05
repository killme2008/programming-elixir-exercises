defmodule FizzBuzz3 do
  def upto(n) do
    Enum.map 1..n, &fizzbuzz/1
  end

  def fizzbuzz(x) when rem(x, 3) == 0 and rem(x, 5) == 0, do: "FizzBuzz"
  def fizzbuzz(x) when rem(x, 3) == 0, do: "Fizz"
  def fizzbuzz(x) when rem(x, 5) == 0, do: "Buzz"
  def fizzbuzz(x), do: x
end
