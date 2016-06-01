local window = require("prox.window")
local gamestate = require("prox.hump.gamestate")

local mouse = {}

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

function mouse.getWorldPosition()
	local mx, my = mouse.getPosition()
	local cam = gamestate.current():getCamera()
	return mx+cam:getX()-window.getWidth()/2, my+cam:getY()-window.getHeight()/2
end

function mouse.getPosition()
	local mx, my = love.mouse.getPosition()
	local sc = window.getScale()

	return mx/sc, my/sc
end

function mouse.clear()
	for i,v in ipairs(state.pressed) do
		state.pressed[i] = false
	end
	for i,v in ipairs(state.released) do
		state.released[i] = false
	end
end

return mouse
