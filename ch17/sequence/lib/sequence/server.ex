defmodule Sequence.Server do
  use GenServer

  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def next_number() do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment(delta) do
    GenServer.cast(__MODULE__, {:increment, delta})
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, _state) do
    {:reply, new_number, new_number}
  end

  def handle_cast({:increment, delta}, current_number) do
    {:noreply, current_number + delta}
  end

end
