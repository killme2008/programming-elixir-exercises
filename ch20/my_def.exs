defmodule MyDef do
  defmacro mydef(name) do
    quote bind_quoted: [name: name] do
      # disable unquoting while still
      # injecting the desired variables into the tree
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Test do
  require MyDef
  [ :fred, :bert ] |> Enum.each(&MyDef.mydef/1)
end

IO.puts Test.fred
