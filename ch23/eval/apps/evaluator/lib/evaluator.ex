defmodule Evaluator do
  def eval(list_of_exprs) do
    { result, _final_binding } =
      Enum.reduce(list_of_exprs, {_result = [], _binding = binding() },
                  &eval_with_binding/2)
    Enum.reverse(result)
  end
  def eval_with_binding(expr, { result, binding }) do
    { next_result, new_binding } = Code.eval_string(expr, binding)
    { [ "value> #{next_result}", "code> #{expr}" | result], new_binding}
  end
end
