#example in http://elixir-lang.org/docs/v1.0/elixir/Kernel.SpecialForms.html#quote/2

defmodule Math do
  defmacro squared(x) do
    quote do
      unquote(x) * unquote(x)
    end
  end
  defmacro squared2(x) do
    quote do
      x = unquote(x)
      x * x
    end
  end
end

defmodule Test do
  require Math
  def my_number do
    IO.puts "Returning 5"
    5
  end

  def test do
    IO.puts "Got #{Math.squared(5)}"
    IO.puts "Got #{Math.squared(my_number())}"
    IO.puts "Got #{Math.squared2(my_number())}"
  end
end

Test.test
