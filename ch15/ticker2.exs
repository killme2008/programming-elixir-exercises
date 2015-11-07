defmodule Ticker2 do
	@name :ticker2
  @tick 2000

  def start do
    pid = spawn_link(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client) do
    send :global.whereis_name(@name), {:register, client}
  end

  def stop do
    send :global.whereis_name(@name), {:stop}
  end

  def generator(no_tick_clients, tick_clients) do
    receive do
      {:register, client} ->
        generator(no_tick_clients ++ [client], tick_clients)
      {:stop} ->
        exit(:normal)
    after @tick ->
        case {no_tick_clients,tick_clients}  do
          {[], []} ->
            generator(no_tick_clients, tick_clients)
          {[], [client | tail]} ->
            send client, {:tick, @tick}
            generator(tail, [client])
          {[client | tail], _} ->
            send client, {:tick, @tick}
            generator(tail, tick_clients ++ [client])
        end
    end
  end
end
