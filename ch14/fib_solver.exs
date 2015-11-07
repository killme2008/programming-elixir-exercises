defmodule FibSolver do
  def run(scheduler) do
    send scheduler, {:ready, self}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, _fib(n), self}
        run(scheduler)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def _fib(0), do: 0
  def _fib(1), do: 1
  def _fib(n) do
    _fib(n-2) + _fib(n-1)
  end
end
