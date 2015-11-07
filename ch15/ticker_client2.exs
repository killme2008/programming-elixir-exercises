defmodule TickerClient2 do
	def run do
    pid = spawn_link(__MODULE__, :got_tick, [epoch()])
    Ticker2.register(pid)
  end

  def epoch do
    {mega, sec, _} = :erlang.now
    (mega * 1000000) + sec
  end

  def got_tick(last_t) do
    receive do
      {:tick, _} ->
        now = epoch()
        IO.puts "Got tick: #{inspect(now-last_t)}"
        got_tick(now)
    end
  end
end
