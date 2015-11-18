defmodule Stack.Stash do
  use GenServer

  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def get_value() do
    GenServer.call(__MODULE__, :get)
  end

  def set_value(v) do
    GenServer.cast(__MODULE__, {:set_value, v})
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set_value, v}, _state) do
    {:noreply, v}
  end


end
