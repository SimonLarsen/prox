local window = require("prox.window")

local mouse = {}

local wheel = {
	x = 0,
	y = 0
}

local state = {
	down = {},
	pressed = {},
	released = {}
}

function mouse.wasPressed(...)
	for i,v in ipairs({...}) do
		if state.pressed[v] == true then return true end
	end
	return false
end

function mouse.wasReleased(...)
	for i,v in ipairs({...}) do
		if state.released[v] == true then return true end
	end
	return false
end

function mouse.isDown(...)
	for i,v in ipairs({...}) do
		if state.down[v] == true then return true end
	end
	return false
end

function mouse.keypressed(k)
	state.down[k] = true
	state.pressed[k] = true
end

function mouse.keyreleased(k)
	state.down[k] = false
	state.released[k] = true
end

function mouse.wheelmoved(x, y)
	wheel.x = wheel.x + x
	wheel.y = wheel.y + y
end

function mouse.getPosition()
	local mx, my = love.mouse.getPosition()
	local canvas_x, canvas_y, _, canvas_sx, canvas_sy = window._getCanvasParams()
	return (mx - canvas_x) / canvas_sx, (my - canvas_y) / canvas_sy
end

function mouse.getX()
    local mx, my = mouse.getPosition()
    return mx
end

function mouse.getY()
    local mx, my = mouse.getPosition()
    return my
end

function mouse.getAxis(name)
	return wheel[name]
end

function mouse.clear()
	wheel.x = 0
	wheel.y = 0

	for i,v in pairs(state.pressed) do
		state.pressed[i] = false
	end
	for i,v in pairs(state.released) do
		state.released[i] = false
	end
end

return mouse
