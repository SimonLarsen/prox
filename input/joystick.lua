local joystick = {}

local state = {}

local get_state = function(joy)
	if state[joy] == nil then
		state[joy] = {
			down = {},
			pressed = {},
			released = {}
		}
	end

	return state[joy]
end

function joystick.wasPressed(joy, ...)
	for i,v in ipairs({...}) do
		if get_state(joy).pressed[v] then return true end
	end
	return false
end

function joystick.wasReleased(joy, ...)
	for i,v in ipairs({...}) do
		if get_state(joy).released[v] then return true end
	end
	return false
end

function joystick.isDown(joy, ...)
	for i,v in ipairs({...}) do
		if get_state(joy).down[v] then return true end
	end
	return false
end

function joystick.keypressed(joy, k)
	get_state(joy).down[k] = true
	get_state(joy).pressed[k] = true
end

function joystick.keyreleased(joy, k)
	get_state(joy).down[k] = false
	get_state(joy).released[k] = true
end

function joystick.getAxis(joy, name)
	if joy > love.joystick.getJoystickCount() then
		return 0
	else
		local joystick = love.joystick.getJoysticks()[joy]
		return joystick:getGamepadAxis(name)
	end
end

function joystick.setVibration(joy, left, right, duration)
	local joystick = love.joystick.getJoysticks()[joy]
	joystick:setVibration(left, right, duration)
end

function joystick.clear()
	for _, s in pairs(state) do
		for i,v in pairs(s.pressed) do
			s.pressed[i] = false
		end

		for i,v in pairs(s.released) do
			s.released[i] = false
		end
	end
end

return joystick
