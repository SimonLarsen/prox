local keyboard = {}

local state = {
	down = {},
	pressed = {},
	released = {}
}

function keyboard.wasPressed(...)
	for i,v in ipairs({...}) do
		if state.pressed[v] == true then return true end
	end
	return false
end

function keyboard.wasReleased(...)
	for i,v in ipairs({...}) do
		if state.released[v] == true then return true end
	end
	return false
end

function keyboard.isDown(...)
	for i,v in ipairs({...}) do
		if state.down[v] == true then return true end
	end
	return false
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
