local keyboard = require("prox.input.keyboard")
local Binding = require("prox.input.Binding")

local KeyboardBinding = class("prox.input.KeyboardBinding", Binding)

function KeyboardBinding:initialize()
	Binding.initialize(self)

	self._actions = {}
	self._axes = {}
end

function KeyboardBinding:add(action, key)
	self._actions[action] = key
end

function KeyboardBinding:addAxis(name, neg, pos)
	local a = {
		neg = neg,
		pos = pos
	}
	self._axes[name] = a
end

function KeyboardBinding:wasPressed(...)
	for i,v in ipairs({...}) do
		if keyboard.wasPressed(self._actions[v]) then return true end
	end
	return false
end

function KeyboardBinding:wasReleased(...)
	for i,v in ipairs({...}) do
		if keyboard.wasPressed(self._actions[v]) then return true end
	end
	return false
end

function KeyboardBinding:isDown(...)
	for i,v in ipairs({...}) do
		if keyboard.isDown(self._actions[v]) then return true end
	end
	return false
end

function KeyboardBinding:getAxis(name)
	local neg = keyboard.isDown(self._axes[name].neg) and 1 or 0
	local pos = keyboard.isDown(self._axes[name].pos) and 1 or 0
	return pos - neg
end

return KeyboardBinding
