defmodule Sorter do
	def sort(list) do
    Enum.sort_by list, fn(s) ->
      [[n]] = Regex.scan(~r/\d+/, s)
      String.to_integer(n)
    end, &>=/2
  end
end
