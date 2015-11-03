defmodule Attendee do
	defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(a = %Attendee{}) do
    a.paid && a.over_18
  end

  def print_vid_badge(a = %Attendee{name: name}) when name !="" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vid_badge(a = %Attendee{}) do
    raise "Missing name for badege"
  end
end
