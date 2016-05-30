local keyboard = {}

local state = {}
state.down = {}
state.pressed = {}
state.released = {}

function keyboard.wasPressed(k)
	return state.pressed[k] == true
end

function keyboard.wasReleased(k)
	return state.released[k] == true
end

function keyboard.isDown(k)
	return state.down[k] == true
end

function keyboard.keypressed(k)
	state.down[k] = true
	state.pressed[k] = true
end

function keyboard.keyreleased(k)
	state.down[k] = false
	state.released[k] = true
end

function keyboard.clear()
	for i,v in pairs(state.pressed) do
		state.pressed[i] = false
	end
	for i,v in pairs(state.released) do
		state.released[i] = false
	end
end

return keyboard
