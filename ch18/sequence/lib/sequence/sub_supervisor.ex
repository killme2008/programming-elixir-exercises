defmodule Sequence.SubSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Sequence.Stash, [Application.get_env(:sequence, :initial_number)])
    ]
    supervise(children, strategy: :one_for_one)
  end

end
