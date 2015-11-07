defmodule Link4 do
  import :timer, only: [sleep: 1]
	def sad_function() do
    sleep 500
    exit(:boom)
  end
  def run() do
    {pid, ref} = spawn_monitor(__MODULE__, :sad_function, [])
    IO.puts inspect(ref)
    IO.puts inspect(pid)
    receive do
      msg ->
        ## receive {:DOWN, ref, :process, pid}
        IO.puts "Message received: #{inspect(msg)}"
    after 1000 ->
        IO.puts "Nothing happened as fa as i com concerned."
    end
  end
end
