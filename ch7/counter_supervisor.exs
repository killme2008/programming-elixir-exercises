defmodule CounterSupervisor do
  use Supervisor

  def start_link(v \\ 0) do
    Supervisor.start_link(__MODULE__, v)
  end

  @counter_name Counter
  #supervisor callback
  def init(v) do
    children = [
      worker(Counter, [v, [name: @counter_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
