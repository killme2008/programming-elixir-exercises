defmodule MyUnless do
  defmacro unless(clause, then_clause, else_clause \\ nil) do
    quote do
      if !unquote(clause) do
        unquote(then_clause)
      else
        unquote(else_clause)
      end
    end
  end
end
