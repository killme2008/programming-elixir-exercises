defmodule ContextHygiene do
  defmacro write do
    quote do
      var!(a, ContextHygiene) = 1
    end
  end

  defmacro read do
    quote do
      var!(a, ContextHygiene)
    end
  end
end

defmodule Test do
  require ContextHygiene
  ContextHygiene.write
  IO.puts ContextHygiene.read
end
