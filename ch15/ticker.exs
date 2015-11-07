defmodule Ticker do
	@name :ticker
  @tick 2000

  def start do
    pid = spawn_link(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client) do
    send :global.whereis_name(@name), {:register, client}
  end

  def stop do
    send :global.whereis_name(@name), {:stop}
  end

  def generator(clients) do
    receive do
      {:register, client} ->
        generator([client | clients])
      {:stop} ->
        exit(:normal)
    after @tick ->
        Enum.each clients, fn client ->
          send client, {:tick, @tick}
        end
        generator(clients)
    end
  end
end
