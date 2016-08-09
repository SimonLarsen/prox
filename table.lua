local ptable = {}

--- Returns first element in table.
function ptable.first(t)
	return t[1]
end

--- Returns last element in table.
function ptable.last(t)
	return t[#t]
end

--- Returns shallow copy of table.
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

function ptable.find(t, value)
	local out = {}
	for i,v in ipairs(t) do
		if v == value then
			table.insert(out)
		end
	end
	return out
end

function ptable.find_if(t, f)
	local out = {}
	for i,v in ipairs(t) do
		if f(v) then
			table.insert(out, v)
		end
	end
	return out
end

function ptable.count(t, value)
	local count = 0
	for i,v in ipairs(t) do
		if v == value then
			count = count + 1
		end
	end
	return count
end

function ptable.count_if(t, f)
	local count = 0
	for i,v in ipairs(t) do
		if f(v) then
			count = count + 1
		end
	end
	return count
end

return ptable
