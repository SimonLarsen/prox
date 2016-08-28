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

function JoystickBinding:wasPressed(...)
	for i,v in ipairs({...}) do
		if joystick.wasPressed(self._joy, self._actions[v]) then return true end
	end
	return false
end

function JoystickBinding:isDown(...)
	for i,v in ipairs({...}) do
		if joystick.isDown(self._joy, self._actions[v]) then return true end
	end
	return false
end

function JoystickBinding:getAxis(name)
	local v = joystick.getAxis(self._joy, name)
	return math.abs(v) >= self._deadzone and v or 0
end

function JoystickBinding:setVibration(left, right, duration)
	joystick.setVibration(self._joy, left, right, duration)
end

return JoystickBinding
