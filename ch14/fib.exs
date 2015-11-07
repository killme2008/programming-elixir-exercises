jobs = [37, 37, 37, 37, 37, 37]

Enum.each 1..20, fn n_processes ->
  {time, result} = :timer.tc(FibScheduler, :run,
                             [n_processes, FibSolver, :run, jobs])
  if n_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B   ~.2f~n", [n_processes, time/1000000.0]
end
