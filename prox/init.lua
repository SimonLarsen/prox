class = require("prox.middleclass.middleclass")
require("prox.slam.slam")

local gamestate = require("prox.hump.gamestate")

local prox = {
	load = function() end,
	exit = function() end,

	Animation = require("prox.Animation"),
	Animator = require("prox.Animator"),
	Entity = require("prox.Entity"),
	gamestate = require("prox.hump.gamestate"),
	JoystickBinding = require("prox.input.JoystickBinding"),
	KeyboardBinding = require("prox.input.KeyboardBinding"),
	resources = require("prox.resources"),
	Scene = require("prox.Scene"),
	screen = require("prox.screen"),
	timer = require("prox.hump.timer")
}

function love.load()
	prox.load()
end

function love.update(dt)
	gamestate.current():update(dt)
end

function love.draw()
	gamestate.current():draw()
end

function love.gui()
	gamestate.current():gui()
end

function love.exit()
	prox.exit()
end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
	local dt = 0
 
	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(0.001) end
	end
 
end

return prox
