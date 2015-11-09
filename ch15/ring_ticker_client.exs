defmodule RingTickerClient do
  def run do
    pid = spawn_link(__MODULE__, :got_tick, [])
    RingTicker.register(pid)
  end

  def got_tick do
    receive do
      {:tick, _} ->
        IO.puts "Got tick! #{inspect(self)}"
        got_tick()
    after RingTicker.tick_timeout ->
        RingTicker.send_next_tick(self)
        got_tick()
    end
  end
end
