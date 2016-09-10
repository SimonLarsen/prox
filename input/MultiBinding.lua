local Binding = require("prox.input.Binding")
local pmath = require("prox.math")
local MultiBinding = class("prox.input.MultiBinding", Binding)

function MultiBinding:initialize(bindings)
	Binding.initialize(self)

	self._bindings = {}
	if bindings then
		for i,v in ipairs(bindings) do
			table.insert(self._bindings, v)
		end
	end
end

function MultiBinding:wasPressed(...)
	for i,v in ipairs(self._bindings) do
		if v:wasPressed(...) then return true end
	end
	return false
end

function MultiBinding:wasReleased(...)
	for i,v in ipairs(self._bindings) do
		if v:wasReleased(...) then return true end
	end
	return false
end

function MultiBinding:isDown(...)
	for i,v in ipairs(self._bindings) do
		if v:isDown(...) then return true end
	end
	return false
end

function MultiBinding:getAxis(name)
	local value = 0
	for i,v in ipairs(self._bindings) do
		value = value + v:getAxis(name)
	end
	return prox.math.cap(value, -1 ,1)
end

return MultiBinding
