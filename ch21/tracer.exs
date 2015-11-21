defmodule Tracer do
	defmacro def(definition, do: body) do
    {name, args} = extract_name_args(definition)
    quote do
       Kernel.def(unquote(definition)) do
         IO.puts IO.ANSI.format([:blue, "==> Call:  ", "#{Tracer.dump_fn(unquote(name), unquote(args))}"], true)
         result = unquote(body)
         IO.puts IO.ANSI.format([:yellow, "<== result:"," #{result}"], true)
         result
       end
    end
  end

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_fn(name,args) do
    "#{name} (#{dump_args(args)})"
  end

  def extract_name_args({:when, _, [{name, _, args}, _]}) do
    {name, args}
  end

  def extract_name_args({name, _, args}) do
    {name, args}
  end

  defmacro __using__(_extras) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer
  def puts_sum_three(a, b, c), do: IO.inspect(a+b+c)
  def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))
  def times_4(n) when is_integer(n), do: n*4
end

Test.puts_sum_three(1, 2, 3)
Test.add_list([1, 2, 3, 4, 5, 6])
Test.times_4(3)
