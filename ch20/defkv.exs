defmodule KV do
  defmacro defkv(kv) do
    quote bind_quoted: [kv: kv] do
      Enum.each kv, fn {k, v} ->
        def unquote(k)(), do: unquote(v)
      end
    end
  end
end

defmodule Test do
	require KV
  @kv [foo: 1, bar: 2]
  KV.defkv @kv
end

IO.puts Test.foo
IO.puts Test.bar
