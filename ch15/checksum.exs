defmodule Checksum do
  use Bitwise
  def checksum(s) do
    _checksum(0, s)
  end

  def _checksum(lrc, <<>>) do
    lrc
  end
  def _checksum(lrc, <<b :: integer-size(8), tail :: binary>>) do
    _checksum(band(bxor(lrc, b), 0xFF), tail)
  end
end
