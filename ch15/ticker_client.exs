defmodule TickerClient do
  def run do
    pid = spawn_link(__MODULE__, :got_tick, [])
    Ticker.register(pid)
  end

  def got_tick do
    receive do
      {:tick, _} ->
        IO.puts "Got tick!"
        got_tick()
    end
  end
end
