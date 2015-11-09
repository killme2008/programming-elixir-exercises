defmodule Sequence do
  use GenServer

  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, state) do
    {:reply, new_number, new_number}
  end
end
