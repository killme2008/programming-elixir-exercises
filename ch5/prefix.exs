prefix = fn
	p ->
	fn
		other ->
			p <> " " <> other
	end
end

mrs = prefix.("Mrs")
mrs.("Smith")
