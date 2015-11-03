people = [
  %{name: "a", height: 1.24},
  %{name: "b", height: 1.34},
  %{name: "c", height: 1.54},
  %{name: "d", height: 1.74},
  %{name: "e", height: 1.84},
  %{name: "f", height: 2.24}
]

for person = %{height: height} <- people, height > 1.5 do
  IO.inspect person
end
