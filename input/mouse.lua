local window = require("prox.window")
local gamestate = require("prox.hump.gamestate")

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

function mouse.wasPressed(k)
	return state.pressed[k] == true
end

function mouse.wasReleased(k)
	return state.released[k] == true
end

function mouse.isDown(k)
	return state.down[k] == true
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

function mouse.getWorldPosition()
	return gamestate.current():getCamera():screenToWorld(mouse.getPosition())
end

function mouse.getPosition()
	local mx, my = love.mouse.getPosition()
	local sc = window.getScale()
	return mx/sc, my/sc
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
