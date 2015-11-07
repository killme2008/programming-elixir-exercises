defmodule FibScheduler do
  def run(num_processes, module, func, jobs) do
    (1..num_processes)
    |> Enum.map(fn (_) ->
      spawn_link(module, func, [self]) end)
    |> schedule_processes(jobs, [])
  end
  def schedule_processes(processes, jobs, results) do
    receive do
      {:ready, worker} when length(jobs) > 0 ->
        [ job | tail ] = jobs
        send worker, {:fib, job, self}
        schedule_processes(processes, tail, results)
      {:ready, worker} ->
        send worker, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, worker), jobs, results)
        else
          Enum.sort_by(results, fn {n,_} -> n end)
        end
      {:answer, n, result, _pid} ->
        schedule_processes(processes, jobs, [{n, result} | results])
      msg ->
        IO.puts "Received msg in scheduler #{inspect(msg)}"
    end
  end
end
