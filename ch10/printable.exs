defmodule Printable do
	def printable?(str) do
    Enum.all?(str, fn ch ->
      ch >=32 and ch <= 126
    end)
  end
end
