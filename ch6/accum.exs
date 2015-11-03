defmodule Accumulate do
	def accum(0,ret), do: ret
	def accum(n,ret), do: accum(n-1, n+ret)
	def accum(n), do: accum(n, 0)
end
