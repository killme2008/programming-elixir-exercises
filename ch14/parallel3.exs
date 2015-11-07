defmodule Parallel3 do
	def pmap(list, f, timeout) do
    me = self
    list
    |> Enum.map(fn (x) ->
      spawn fn -> send me, {self, f.(x)} end
    end)
    |> Enum.map(fn (pid) ->
      receive do
        {^pid, ret} ->
          ret
      after timeout ->
          :timeout
      end
    end)
  end
end
