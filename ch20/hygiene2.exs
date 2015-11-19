defmodule Hygiene2 do
  defmacro write do
    quote do
      a = 1
    end
  end

  defmacro read do
    quote do
      a
    end
  end
end
defmodule Test do
  require Hygiene2
  Hygiene2.write
  Hygiene2.read
end
