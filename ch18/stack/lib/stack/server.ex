defmodule Stack.Server do
  use GenServer

  # Client API
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(e) do
    GenServer.cast(__MODULE__, {:push, e})
  end

  def stop do
    GenServer.cast(__MODULE__, :stop)
  end

  def terminate(reason, state) do
    Stack.Stash.set_value(state)
  end

  # Server callbacks
  def init(:ok) do
    {:ok, Stack.Stash.get_value()}
  end

  def handle_call(:pop, _from, [e | tail]) do
    {:reply, {:ok, e}, tail}
  end

  def handle_cast({:push, e}, list) do
    {:noreply, [e | list]}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "Stack current state is '#{inspect(state)}', and it's greate."}]]
  end
end
