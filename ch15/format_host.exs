defmodule FormatHost do
	def format_host(s) do
    if s =~ ~r/\d+\.\d+\.\d+\.\d+/ do
      s |> String.split(".") |> Enum.map(&String.to_integer/1) |> List.to_tuple
    else
      String.to_char_list s
    end
  end
end
