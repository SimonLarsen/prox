local Queue = class("prox.containers.Queue")

function Queue:initialize()
	self._entries = {}
end

function Queue:enqueue(o)
	table.insert(self._entries, 1, o)
end

function Queue:dequeue()
	assert(#self._entries > 0, "Cannot dequeue empty queue.")
	local o = self._entries[#self._entries]
	table.remove(self._entries, #self._entries)
	return o
end

function Queue:peek()
	assert(#self._entries > 0, "Cannot peek empty queue")
	return self._entries[#self._entries]
end

function Queue:size()
	return #self._entries
end

function Queue:isEmpty()
	return self:size() == 0
end

return Queue
