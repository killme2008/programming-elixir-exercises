defmodule Pipe do
	defmacro a|>b do
    pos  = tuple_size(b) -1
    Macro.pipe(a, b, pos)
  end

  defmacro __using__(_extras) do
    quote do
      import Kernel, except: [|>: 2]
      import Pipe
    end
  end

  def map(f, c) do
    Enum.map(c, f)
  end
  def join(sep, c) do
    Enum.join(c, sep)
  end
end

defmodule Test do
	use Pipe
  IO.puts ([1,2,3] |> map(&(&1+1)) |> join(" "))
end
