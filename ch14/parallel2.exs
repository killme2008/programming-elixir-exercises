defmodule Parallel2 do
	def pmap(list, f) do
    me = self
    list
    |> Enum.map(fn (x) ->
      spawn fn -> send me, {self, f.(x)} end
    end)
    |> Enum.map(fn (pid) ->
      receive do
        {_pid, ret} ->
          ret
      end
    end)
  end
end
