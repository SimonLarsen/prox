local joystick = require("prox.input.joystick")
local Binding = require("prox.input.Binding")

local JoystickBinding = class("prox.input.JoystickBinding", Binding)

JoystickBinding.DEFAULT_DEADZONE = 0.0

function JoystickBinding:initialize(joy, deadzone)
	Binding.initialize(self)

	self.joy = joy
	self.deadzone = deadzone or JoystickBinding.DEFAULT_DEADZONE
	self.actions = {}
end

function JoystickBinding:add(action, key)
	self.actions[action] = key
end

function JoystickBinding:wasPressed(action, consume)
	return joystick.wasPressed(self.joy, self.actions[action], consume)
end

function JoystickBinding:isDown(action)
	return joystick.isDown(self.joy, self.actions[action])
end

function JoystickBinding:getAxis(name)
	local v = joystick.getAxis(self.joy, name)
	return math.abs(v) >= self.deadzone and v or 0
end

return JoystickBinding
