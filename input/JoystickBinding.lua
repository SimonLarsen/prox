local joystick = require("prox.input.joystick")
local Binding = require("prox.input.Binding")

local JoystickBinding = class("prox.input.JoystickBinding", Binding)

JoystickBinding.DEFAULT_DEADZONE = 0.0

function JoystickBinding:initialize(joy, deadzone)
	Binding.initialize(self)

	self._joy = joy
	self._deadzone = deadzone or JoystickBinding.DEFAULT_DEADZONE
	self._actions = {}
end

function JoystickBinding:add(action, key)
	self._actions[action] = key
end

function JoystickBinding:wasPressed(action)
	return joystick.wasPressed(self._joy, self._actions[action])
end

function JoystickBinding:isDown(action)
	return joystick.isDown(self._joy, self._actions[action])
end

function JoystickBinding:getAxis(name)
	local v = joystick.getAxis(self._joy, name)
	return math.abs(v) >= self._deadzone and v or 0
end

return JoystickBinding
