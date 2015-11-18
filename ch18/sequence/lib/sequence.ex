defmodule Sequence do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      supervisor(Sequence.SubSupervisor, []),
      worker(Sequence.Server, [])
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
