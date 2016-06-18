local Stack = class("prox.containers.Stack")

function Stack:initialize()
	self._entries = {}
end

function Stack:push(o)
	table.insert(self._entries, o)
end

function Stack:peek()
	assert(#self._entries > 0, "Cannot peek empty stack")
	return self._entries[#self._entries]
end

function Stack:pop()
	assert(#self._entries > 0, "Cannot pop empty stack")
	local o = self:peek()
	table.remove(self._entries, #self._entries)
	return o
end

function Stack:size()
	return #self._entries
end

function Stack:isEmpty()
	return self:size() == 0
end

return Stack
