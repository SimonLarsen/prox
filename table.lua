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

--- Copies all entries in from into to.
-- Does not perform deep copy of table entries.
function ptable.copy_into(from, to)
	for i,v in pairs(from) do
		to[i] = ptable.copy(v)
	end
end

--- Inserts contents of table t2 into table t.
function ptable.insert_all(t, t2)
	for i,v in pairs(t2) do
		table.insert(t, v)
	end
	return t
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
	for i,v in pairs(t) do
		if v == value then
			table.insert(out)
		end
	end
	return out
end

function ptable.find_if(t, f)
	local out = {}
	for i,v in pairs(t) do
		if f(v) then
			table.insert(out, v)
		end
	end
	return out
end

function ptable.count(t, value)
	local count = 0
	for i,v in pairs(t) do
		if v == value then
			count = count + 1
		end
	end
	return count
end

function ptable.count_if(t, f)
	local count = 0
	for i,v in pairs(t) do
		if f(v) then
			count = count + 1
		end
	end
	return count
end

return ptable
