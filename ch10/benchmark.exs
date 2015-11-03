defmodule Benchmark do
  def	test_avg(m, f, a, n) when n > 0 do
    l = test_loop(m, f, a, n, [])
    len = length(l)
    min = :lists.min(l)
    max = :lists.max(l)
    med = :lists.nth(round((len / 2)), :lists.sort(l))
    avg = round(:lists.foldl(fn (x, sum) -> x + sum end, 0, l) / len)
    :io.format("Range: ~b - ~b mics~n",
              "Median: ~b mics~n",
              "Average: ~b mics~n",
              [min, max, med, avg])
    med
  end

  def test_loop(_m, _f, _a, 0, list), do: list

  def test_loop(m, f, a, n, list) do
    {t, _result} = :timer.tc(m, f, a)
    test_loop(m, f, a, n - 1, [t|list])
  end

end
