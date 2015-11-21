defmodule CSVSigil do
  def sigil_v(lines, _opts) do
    [keys | items] = lines
    |> String.strip
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, ~r/,/) end)
    |> Enum.map(fn values ->
      Enum.map(values, fn v ->
        v |> Integer.parse() |> get_value(v)
      end)
    end)
    keys = Enum.map(keys, &String.to_atom/1)
    items |> Enum.map(fn item -> Enum.zip(keys, item) end)
  end

  def get_value(:error, v), do: v
  def get_value({f, ""}, _), do: f
  def get_value({f, _}, v), do: get_value(Float.parse(v), v)
end

defmodule Test do
  import CSVSigil
  def csv1 do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end

  def csv2 do
    ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Mike,1,2.99
    Battery,6,8.00
    """
  end
end

#IO.puts inspect(Test.csv1)
IO.puts inspect(Test.csv2)
