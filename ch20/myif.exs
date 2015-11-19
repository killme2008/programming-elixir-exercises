defmodule My do
	defmacro if(pred, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      case unquote(pred) do
        val when val in [false, nil] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end

  defmacro unless(pred, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    quote do
      if !unquote(pred) do
        unquote(do_clause)
      end
    end
  end
end

defmodule Test do
	require My
  My.if 1==2 do
    IO.puts "1 == 2"
  else
    IO.puts "1 != 2"
  end

  My.unless Enum.empty?([1, 2, 3]) do
    IO.puts "[1, 2, 3] is not empty"
  end
  My.unless Enum.empty?([]) do
    IO.puts "[] is not empty."
  end
end
