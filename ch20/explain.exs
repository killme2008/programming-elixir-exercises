defmodule Explain do

  def explain_expr({:+, _, [left, right]}) do
    explain_expr(right) <> ", then add " <> explain_expr(left)
  end

  def explain_expr({:*, _, [left, right]}) do
    "multiply " <> explain_expr(left) <> " and " <> explain_expr(right)
  end

  def explain_expr(n) do
    to_string(n)
  end

  defmacro explain([do: clauses]) do
    Explain.explain_expr(clauses)
  end

end
