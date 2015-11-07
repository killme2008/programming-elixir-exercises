defmodule LinkExecs3 do
  import :timer, only: [sleep: 1]
  def sad_function(parent) do
    send parent, :test_msg
    raise "error"
  end

  def receive_msgs() do
    receive do
      msg ->
        IO.puts "Receive msg from child #{inspect(msg)}."
        receive_msgs()
    end
  end

  def run() do
    spawn_monitor(__MODULE__, :sad_function, [self])
    sleep 500
    receive_msgs()
  end
end
