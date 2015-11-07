defmodule Anagrams do
  def anagrams(input) do
    Enum.group_by(input, fn s ->
      s
      |> String.codepoints()
      |> Enum.sort
      |> Enum.join
    end)
    |> Map.values()
  end
end
