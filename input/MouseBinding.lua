local mouse = require("prox.input.mouse")
local Binding = require("prox.input.Binding")

local MouseBinding = class("prox.input.MouseBinding", Binding)

function MouseBinding:initialize()
	Binding.initialize(self)

	self._actions = {}
end

function MouseBinding:add(action, key)
	self._actions[action] = key
end

function MouseBinding:wasPressed(...)
	for i,v in ipairs({...}) do
		if mouse.wasPressed(self._actions[v]) then return true end
	end
	return false
end

function MouseBinding:wasReleased(...)
	for i,v in ipairs({...}) do
		if mouse.wasReleased(self._actions[v]) then return true end
	end
	return false
end

function MouseBinding:isDown(...)
	for i,v in ipairs({...}) do
		if mouse.isDown(self._actions[v]) then return true end
	end
	return false
end

function MouseBinding:getWorldPosition()
	return mouse.getWorldPosition()
end

function MouseBinding:getPosition()
	return mouse.getPosition()
end

return MouseBinding
