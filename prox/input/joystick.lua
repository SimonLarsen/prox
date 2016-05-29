local joystick = {}

local state = {}

function joystick.initialize()
	for i=1,4 do
		state[i] = {
			down = {},
			pressed = {},
			released = {}
		}
	end
end

function joystick.wasPressed(joy, k, consume)
	local s = state[joy].pressed[k] == true
	if consume then
		state[joy].pressed[k] = false
	end
	return s
end

function joystick.wasReleased(joy, k)
	return state[joy].released[k] == true
end

function joystick.isDown(joy, k)
	return state[joy].down[k] == true
end

function joystick.keypressed(joy, k)
	state[joy].down[k] = true
	state[joy].pressed[k] = true
end

function joystick.keyreleased(joy, k)
	state[joy].down[k] = false
	state[joy].released[k] = true
end

function joystick.getAxis(joy, name)
	if joy > love.joystick.getJoystickCount() then
		return 0
	else
		local joystick = love.joystick.getJoystick()[joy]
		return joystick:getGamepadAxis(name)
	end
end

function joystick.clear()
	for joy=1,4 do
		for i,v in pairs(state[joy].pressed) do
			state[joy].pressed[i] = false
		end

		for i,v in pairs(state[joy].released) do
			state[joy].released[i] = false
		end
	end
end

return joystick
