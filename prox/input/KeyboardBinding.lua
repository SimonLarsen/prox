local keyboard = require("prox.input.keyboard")
local Binding = require("prox.input.Binding")

local KeyboardBinding = class("prox.input.KeyboardBinding", Binding)

function KeyboardBinding:initialize()
	Binding.initialize(self)

	self.actions = {}
	self.axes = {}
end

function KeyboardBinding:add(action, key)
	self.actions[action] = key
end

function KeyboardBinding:addAxis(name, neg, pos)
	local a = {
		neg = neg,
		pos = pos
	}
	self.axes[name] = a
end

function KeyboardBinding:wasPressed(action, consume)
	return keyboard.wasPressed(self.actions[action], consume)
end

function KeyboardBinding:isDown(action)
	return keyboard.isDown(self.actions[action])
end

function KeyboardBinding:getAxis(name)
	local neg = self:isDown(self.axes[name].neg) and 1 or 0
	local pos = self:isDown(self.axes[name].pos) and 1 or 0

	return pos - neg
end

return KeyboardBinding
