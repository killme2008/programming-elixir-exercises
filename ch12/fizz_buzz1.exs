defmodule FizzBuzz1 do
  def upto(n) do
    Enum.map 1..n, &fizzbuzz/1
  end

  def fizzbuzz(x) do
    cond do
      rem(x, 5) == 0 and rem(x, 3) == 0 ->
        "FizzBuzz"
      rem(x, 3) ==0 ->
        "Fizz"
      rem(x, 5) == 0 ->
        "Buzz"
      true ->
        x
    end
  end
end
