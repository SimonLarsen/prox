local hump_gamestate = require("prox.hump.gamestate")
local Scene = require("prox.Scene")

local gamestate = {}

function gamestate.init()
	hump_gamestate.switch(Scene())
end

function gamestate.current()
	return hump_gamestate.current()
end

function gamestate.push(entities)
	hump_gamestate.push(Scene(entities))
end

function gamestate.pop()
	hump_gamestate.pop()
end

function gamestate.switch(entities)
	hump_gamestate.switch(Scene(entities))
end

return gamestate
