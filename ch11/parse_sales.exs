defmodule ParseSales do
  def parse(file) do
    {:ok, results} = File.open file, [:read], fn(file) ->
      keys = IO.read(file, :line)
             |> String.strip()
             |> String.split(",")
             |> Enum.map(&String.to_atom/1)

      Enum.map IO.stream(file, :line), fn(line) ->
        [id, ship_to, nam] = line
                              |> String.strip()
                              |> String.split(",")
        {:ok, ship_to} = Code.string_to_quoted(ship_to)
        Enum.zip keys, [String.to_integer(id), ship_to, String.to_float(nam)]
      end
    end
    results
  end
end
