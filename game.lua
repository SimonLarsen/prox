local gamestate = require("prox.hump.gamestate")
local Scene = require("prox.Scene")

local game = {}
local fps = 30

function game.current()
	return gamestate.current()
end

function game.push(entities)
	gamestate.push(Scene(entities))
end

function game.pop()
	gamestate.pop()
end

function game.switch(entities)
	gamestate.switch(Scene(entities))
end

function game.setFPS(new_fps)
	fps = new_fps
end

function game.getFPS()
	return fps
end

return game
