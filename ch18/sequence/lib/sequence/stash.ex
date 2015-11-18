defmodule Sequence.Stash do
  use GenServer
  require Logger
  @vsn "1"

  defmodule State do
    defstruct number: 0, delta: 1
  end


  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  # interface functions
  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def save_state(n, d) do
    GenServer.cast(__MODULE__, {:save_state, n, d})
  end

  # Server callbacks
  def init(number) do
    {:ok, %State{number: number}}
  end

  def handle_call(:get, _from, state) do
    {:reply, {state.number, state.delta}, state}
  end

  def handle_cast({:save_state, n, d}, _state) do
    {:noreply, %State{number: n, delta: d}}
  end

  def code_change("0", old_number, _extras) do
    new_state = %State{number: old_number, delta: 1}
    Logger.info "Changing stash code."
    Logger.info inspect(old_number)
    Logger.info inspect(new_state)

    {:ok, new_state}
  end

end
