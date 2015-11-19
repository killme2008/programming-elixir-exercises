#!/usr/local/bin/elixir
defmodule Frequency do
  @name {:global, __MODULE__}

  def start_link() do
    Agent.start_link(fn -> HashDict.new end, name: @name)
  end

  def add_word(word) do
    Agent.update(@name, fn dict ->
      Dict.update(dict, word, 1, &(&1+1))
    end)
  end

  def count_for(word) do
    Agent.get(@name,fn dict -> Dict.get(dict, word) end)
  end

  def words, do: words(10)

  def words(n) do
    Agent.get(@name, fn dict ->
      dict
      |> Dict.to_list()
      |> Enum.sort_by(fn x -> elem(x, 1) end, &>=/2)
      |> Enum.map(fn x -> elem(x, 0) end)
      |> Enum.take(n)
    end)
  end
end

defmodule WordListLoader do
	def load_from_files(file_names) do
    file_names
    |> Stream.map(&WordListLoader.load_task/1)
    |> Enum.map(&Task.await/1)
  end

  def load_task(name) do
    Task.async(fn ->
      name
      |> File.stream!()
      |> Stream.map(&String.strip/1)
      |> Stream.map(fn line ->
        line
        |> String.split(~r/\s+/)
        |> Enum.map(&String.strip/1)
        |> Enum.filter(fn w -> String.length(w) != 0 end)
      end)
      |> Enum.reduce([], fn x, acc -> acc ++ x end)
      |> Enum.each(&Frequency.add_word/1)
    end)
  end
end

Frequency.start_link
WordListLoader.load_from_files(["./agent_dict.exs","./task.exs"])
top_ten_words = Frequency.words() |> Enum.map(fn w -> "'" <> w <> "'" end) |> Enum.join(" ")
IO.puts "Top ten words: #{top_ten_words}"
