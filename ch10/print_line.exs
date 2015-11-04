defmodule PrintLine do
  def print(list) do
    max_str = Enum.max_by(list, &String.length/1)
    half = round(String.length(max_str)/2)
    Enum.each(list, fn (str) ->
      len = String.length str
      spaces = half - round(len/2)
      IO.puts "#{String.duplicate(" ",spaces)}#{str}"
    end)
  end
end
