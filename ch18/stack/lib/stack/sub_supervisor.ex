defmodule Stack.SubSupervisor do
  use Supervisor

  def start_link(default) do
    Supervisor.start_link(__MODULE__, default, name: __MODULE__)
  end

  def init(default) do
    children = [
      worker(Stack.Stash, [default])
    ]
    supervise(children, strategy: :one_for_one)
  end

end
