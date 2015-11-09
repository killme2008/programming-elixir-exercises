defmodule RingTickerClient do
  def run do
    pid = spawn_link(__MODULE__, :got_tick, [])
    RingTicker.register(pid)
  end

  def got_tick do
    receive do
      {:tick, _} ->
        IO.puts "Got tick! #{inspect(self)}"
        me = self
        spawn fn ->
          receive do
          after RingTicker.tick_timeout ->
              RingTicker.send_next_tick(me)
          end
        end
        got_tick()
    end

  end
end
