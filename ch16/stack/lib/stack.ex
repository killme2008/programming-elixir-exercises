defmodule Stack do
  use GenServer

  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
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
    IO.puts "stack is about to terminate because of '#{inspect(reason)}', and current state is '#{inspect(state)}'"
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:pop, _from, []) do
    {:reply, {:error, :empty}, []}
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
