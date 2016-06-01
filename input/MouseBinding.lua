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

function MouseBinding:wasPressed(action)
	return mouse.wasPressed(self._actions[action])
end

function MouseBinding:isDown(action)
	return mouse.isDown(self._actions[action])
end

function MouseBinding:getWorldPosition()
	return mouse.getWorldPosition()
end

function MouseBinding:getPosition()
	return mouse.getPosition()
end

return MouseBinding
