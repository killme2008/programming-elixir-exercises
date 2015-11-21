defmodule LineSigil do
  def sigil_l(lines, _opts) do
    lines
    |> String.strip()
    |> String.split("\n")
  end
end
