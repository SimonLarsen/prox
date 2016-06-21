class = require("prox.middleclass.middleclass")
require("prox.slam.slam")

local gamestate = require("prox.hump.gamestate")
local window = require("prox.window")
local keyboard = require("prox.input.keyboard")
local mouse = require("prox.input.mouse")
local joystick = require("prox.input.joystick")
local scene = require("prox.scene")
local Scene = require("prox.Scene")

local prox = {
	load = function() end,
	quit = function() end,

	-- core modules
	gui = require("prox.gui"),
	joystick = require("prox.input.joystick"),
	keyboard = require("prox.input.keyboard"),
	mouse = require("prox.input.mouse"),
	resources = require("prox.resources"),
	scene = require("prox.scene"),
	window = require("prox.window"),
	timer = require("prox.hump.timer"),
	math = require("prox.math"),
	table = require("prox.table"),

	-- Base classes
	Entity = require("prox.Entity"),

	-- Renderers
	Animation = require("prox.renderer.Animation"),
	Animator = require("prox.renderer.Animator"),
	Sprite = require("prox.renderer.Sprite"),

	-- Colliders
	BoxCollider = require("prox.collider.BoxCollider"),

	-- Input
	KeyboardBinding = require("prox.input.KeyboardBinding"),
	MouseBinding = require("prox.input.MouseBinding"),
	JoystickBinding = require("prox.input.JoystickBinding")
}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	gamestate.switch(Scene())

	prox.load()
end

function love.quit()
	return prox.quit()
end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	love.load(arg)
 
	-- We don't want the first frame's dt to include time taken by love.load.
	love.timer.step()
 
	local acc = 0

	window.apply()
 
	-- Main loop time.
	while true do
		love.timer.step()
		acc = acc + love.timer.getDelta()

		local current_scene = gamestate.current()
		local dt = 1/scene.getFPS()

		while acc > dt do
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
 
			current_scene:update(dt)
			acc = acc - dt
 
			love.graphics.origin()

			love.graphics.clear()
			love.graphics.setCanvas(window._getCanvas())
			love.graphics.clear(current_scene:getBackgroundColor())

			current_scene:draw()
			current_scene:gui()

			love.graphics.setCanvas()
			love.graphics.draw(window._getCanvas(), window._getCanvasParams())

			love.graphics.present()

			keyboard.clear()
			mouse.clear()
			joystick.clear()
		end
 
		love.timer.sleep(0.001)
	end
end

function love.keypressed(k) keyboard.keypressed(k) end
function love.keyreleased(k) keyboard.keyreleased(k) end
function love.mousepressed(x, y, k) mouse.keypressed(k) end
function love.mousereleased(x, y, k) mouse.keyreleased(k) end
function love.wheelmoved(x, y) mouse.wheelmoved(x, y) end
function love.gamepadpressed(joy, k) joystick.keypressed(joy, k) end
function love.gamepadreleased(joy, k) joystick.keyreleased(joy, k) end

return prox
