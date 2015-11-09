defmodule RingTicker do
	@name :ring_ticker
  @tick 2000

  def tick_timeout, do: @tick

  def start do
    pid = spawn_link(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client) do
    send :global.whereis_name(@name), {:register, client}
  end

  def send_next_tick(client) do
    send :global.whereis_name(@name), {:next_tick, client}
  end


  def stop do
    send :global.whereis_name(@name), {:stop}
  end

  def next_client(clients, client) do
    index  = Enum.find_index(clients, fn(x) -> x === client end)
    {:ok, nc} = Enum.fetch(clients, next_index(length(clients), index))
    nc
  end

  def next_index(n, m) when m+1 == n, do: 0
  def next_index(_n, m), do: m+1

  def generator(clients) do
    receive do
      {:register, client} ->
        #send the seed
        if length(clients) ==0 do
          send client, {:tick, self}
        end
        generator([client | clients])
      {:next_tick, client} ->
        clients
        |> next_client(client)
        |> send({:tick, self})

        generator(clients)
      {:stop} ->
        exit(:normal)
    end
  end
end
