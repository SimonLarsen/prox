local gamestate = require("prox.hump.gamestate")
local Scene = require("prox.Scene")

local scene = {}
local fps = 60

function scene.current()
	return gamestate.current()
end

function scene.push(entities)
	gamestate.push(Scene(entities))
end

function scene.pop()
	gamestate.pop()
end

function scene.switch(entities)
	gamestate.switch(Scene(entities))
end

function scene.setFPS(new_fps)
	fps = new_fps
end

function scene.getFPS()
	return fps
end

return scene
