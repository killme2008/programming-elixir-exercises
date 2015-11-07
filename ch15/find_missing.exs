defmodule FindMissing do
  def find_missing_char(list) do
    min = ?a
    max = ?z
    if Enum.max(list) < ?a do
      min = ?A
      max = ?Z
    end
    chs = Enum.into min..max, []
    diff = chs -- list
    if length(diff) > 0 do
      [result | _] = diff
      result
    end
  end
end
