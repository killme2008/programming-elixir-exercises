defmodule Times do
	defmacro times_n(x) do
    name = String.to_atom "times_#{x}"
    quote do
      def unquote(name)(y) do
        unquote(x) * y
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [times_n: 1]
    end
  end
end

defmodule Test do
	use Times
  times_n(3)
  times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(5)
