local serialize = {}

function serialize.pack(t)
	local ty = type(t)
	if ty == "table" then
		local s = "{"
		for i,v in pairs(t) do
			s = s .. string.format("[%s] = %s, ", serialize.pack(i), serialize.pack(v))
		end
		s = s .. "}"
		return s
	elseif ty == "number" then
		return tostring(t)
	elseif ty == "string" then
		return string.format("\"%s\"", t)
	elseif ty == "boolean" then
		return tostring(t)
	end
end

function serialize.unpack(str)
	local f = loadstring("return " .. str)
	return f()
end

function serialize.write(t, filename)
	local data = serialize.pack(t)
	love.filesystem.write(filename, t)
end

function serialize.read(filename)
	if not love.filesystem.exists(filename) then
		error(string.format("File \"%s\" does not exist", filename))
	end
	local data = love.filesystem.read(filename)
	return serialize.unpack(data)
end

return serialize
