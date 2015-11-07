defmodule Link1 do
  import :timer, only: [sleep: 1]
	def sad_function() do
    sleep 500
    exit(:boom)
  end

  def run() do
    Process.flag(:trap_exit, true)
    spawn(__MODULE__, :sad_function, [])
    receive do
      msg ->
        IO.puts "Message received: #{inspect(msg)}"
    after 1000 ->
        IO.puts "Nothing happened as fa as i com concerned."
    end
  end
end
