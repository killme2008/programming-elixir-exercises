defmodule LinkExecs do
  import :timer, only: [sleep: 1]
  def sad_function(parent) do
    send parent, :test_msg
    exit(:boom)
  end
  def run() do
    spawn_link(__MODULE__, :sad_function, [self])
    sleep 500
    receive do
      msg ->
        IO.puts "Receive msg from child #{inspect(msg)}."
    end
  end
end
