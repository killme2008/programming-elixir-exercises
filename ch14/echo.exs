defmodule Echo do
  def start_process(pid) do
    spawn fn ->
      receive do
        {^pid, msg} ->
          send pid, msg
      end
    end
  end
  def wait_msg(ret) do
    receive do
      msg ->
        wait_msg([msg|ret])
    after 5000 ->
        IO.puts "#{inspect(ret)}"
    end
  end
	def run do
    receiver = spawn fn -> wait_msg([]) end
    processes = Enum.map 1..10, fn (_) ->
      start_process receiver
    end
    processes
      |> Enum.with_index()
      |> Enum.map(fn({pid ,idx}) ->
                   send pid, {receiver, idx}
    end)
    :ok
  end
end
