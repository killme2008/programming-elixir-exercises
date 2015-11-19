defmodule Fib do
	def of(0), do: 0
  def of(1), do: 1
  def of(n), do: of(n-1) + of(n-2)
end

worker = Task.async(fn -> Fib.of(20) end)
result = Task.await(worker)
IO.puts "First task result is #{result}"

worker = Task.async(Fib, :of, [30])
result = Task.await(worker)
IO.puts "Second task result is #{result}"
