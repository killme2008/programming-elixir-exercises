defmodule Convert do
	def convert(s, list) do
    Enum.reduce list, s, fn word, s ->
      String.replace s, word, String.capitalize(word)
    end
  end
end
