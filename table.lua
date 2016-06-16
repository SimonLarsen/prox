local ptable = {}

--- Return shallow copy of table.
function ptable.copy(t)
	if type(t) == "table" then
		local s = {}
		for i,v in pairs(t) do
			s[i] = v
		end
		return s
	else
		return t
	end
end

--- Generates integer sequence [a, b].
function ptable.seq(a, b)
	local t = {}
	for i=a, b do
		table.insert(t, i)
	end
	return t
end

--- Shuffle table order using Fisher-Yates algorithm.
function ptable.shuffle(a)
	for i=#a, 2, -1 do
		local j = love.math.random(1, i)
		local tmp = a[j]
		a[j] = a[i]
		a[i] = tmp
	end
	return a
end

return ptable
