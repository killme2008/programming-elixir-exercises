defmodule Operators do
	defmacro a+b  do
    quote do
      to_string(unquote(a)) <> to_string(unquote(b))
    end
  end
  defmacro a|>b do
    pos  = tuple_size(b) -1
    Macro.pipe(a, b, pos)
  end
  defmacro __using__(_extras) do
    quote do
      import Kernel, except: [+: 2,|>: 2]
      import Operators
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
	IO.puts(123+456)
  use Operators
  IO.puts(123+456)
  IO.puts ([1,2,3] |> map(&(&1+1)) |> join(" "))
end

IO.puts(123+456)
