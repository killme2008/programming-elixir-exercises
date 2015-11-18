defmodule Sequence.Server do
  use GenServer
  require Logger

  defmodule State do
    defstruct current_number: 0, delta: 1
  end

  @vsn "2"

  # Client API
  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def next_number() do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment(delta) do
    GenServer.cast(__MODULE__, {:increment, delta})
  end

  # Server callbacks
  def init(:ok) do
    {n, d} = Sequence.Stash.get()
    {:ok, %State{current_number: n, delta: d}}
  end

  def handle_call(:next_number, _from, state) do
    {:reply, state.current_number,
     %{state | current_number: state.current_number + state.delta}}
  end

  def handle_call({:set_number, new_number}, _from, state) do
    {:reply, new_number, %{state | current_number: new_number}}
  end

  def handle_cast({:increment, delta}, state) do
    {:noreply,
     %{state | current_number: state.current_number + delta, delta: delta}}
  end

  def terminate(reason, state) do
    Logger.info "Terminated with reason #{inspect(reason)}"
    Logger.info "Save state #{inspect(state)} to stash."
    Sequence.Stash.save_state(state.current_number, state.delta)
  end

  def code_change("1", state, _extra) do
    Logger.info "Changing Sequence.Server code from 0 to 1."
    Logger.info inspect(state)
    {:ok, state}
  end

end
