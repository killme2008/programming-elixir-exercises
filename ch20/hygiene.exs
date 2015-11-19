defmodule Hygiene do
  defmacro no_interference do
    quote do: a = 1
  end
end
defmodule Test do
  require Hygiene
  def test  do
    a = 10
    Hygiene.no_interference
    IO.puts a
  end
end

Test.test
