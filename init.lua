class = require("prox.middleclass.middleclass")
require("prox.slam.slam")
local suit = require("prox.SUIT")

local window = require("prox.window")
local keyboard = require("prox.input.keyboard")
local mouse = require("prox.input.mouse")
local joystick = require("prox.input.joystick")
local gamestate = require("prox.gamestate")

local prox = {
	load = function() end,
	quit = function() end,

	-- core modules
	gui = suit,
	joystick = require("prox.input.joystick"),
	keyboard = require("prox.input.keyboard"),
	math = require("prox.math"),
	mouse = require("prox.input.mouse"),
	resources = require("prox.resources"),
	gamestate = require("prox.gamestate"),
	serialize = require("prox.serialize"),
	window = require("prox.window"),
	timer = require("prox.hump.timer"),
	table = require("prox.table"),
	string = require("prox.string"),
	time = require("prox.time"),

	-- Core classes
	Entity = require("prox.Entity"),

	-- Renderers
	Animation = require("prox.renderer.Animation"),
	Animator = require("prox.renderer.Animator"),
	MultiRenderer = require("prox.renderer.MultiRenderer"),
	Sprite = require("prox.renderer.Sprite"),

	-- Colliders
	BoxCollider = require("prox.collider.BoxCollider"),

	-- Input
	KeyboardBinding = require("prox.input.KeyboardBinding"),
	MouseBinding = require("prox.input.MouseBinding"),
	JoystickBinding = require("prox.input.JoystickBinding"),
	MultiBinding = require("prox.input.MultiBinding")
}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineStyle("rough")
	window.apply()

	gamestate.init()

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
	local dt = 0

	-- Main loop time.
	while true do
		-- Process events.
		love.event.pump()
		for name, a,b,c,d,e,f in love.event.poll() do
			if name == "quit" then
				if not love.quit or not love.quit() then
					return a
				end
			end
			love.handlers[name](a,b,c,d,e,f)
		end

		-- Update dt, as we'll be passing it to update
		love.timer.step()
		dt = math.min(love.timer.getDelta(), window._getMaxDelta())

		-- Call update and draw
		gamestate.current():update(dt)

		if love.graphics.isActive() then
			love.graphics.origin()

			love.graphics.clear()
			love.graphics.setCanvas(window._getCanvas())
			love.graphics.clear(gamestate.current():getBackgroundColor())

			gamestate.current():draw()
			gamestate.current():gui()
			suit.draw()

			love.graphics.setCanvas()
			love.graphics.setShader(window._getShader())
			love.graphics.draw(window._getCanvas(), window._getCanvasParams())
			love.graphics.setShader()

			love.graphics.present()
		end

		keyboard.clear()
		mouse.clear()
		joystick.clear()

		love.timer.sleep(0.001)
	end
end

function love.keypressed(k)
	keyboard.keypressed(k)
	suit.keypressed(k)
end

function love.textinput(t)
	suit.textinput(t)
end

function love.keyreleased(k) keyboard.keyreleased(k) end
function love.mousepressed(x, y, k) mouse.keypressed(k) end
function love.mousereleased(x, y, k) mouse.keyreleased(k) end
function love.wheelmoved(x, y) mouse.wheelmoved(x, y) end
function love.gamepadpressed(joy, k) joystick.keypressed(joy:getID(), k) end
function love.gamepadreleased(joy, k) joystick.keyreleased(joy:getID(), k) end

-- monkey patch suit core for prox mouse input
local suit_core = require("prox.SUIT.core")
local SUIT_NONE = {}
function suit_core:enterFrame()
	if not self.mouse_button_down then
		self.active = nil
	elseif self.active == nil then
		self.active = SUIT_NONE
	end

	self.hovered_last, self.hovered = self.hovered, nil
	local mx, my = prox.mouse.getPosition()
	self:updateMouse(mx, my, prox.mouse.isDown(1))
	self.key_down, self.textchar = nil, ""
	self:grabKeyboardFocus(SUIT_NONE)
	self.hit = nil
end

return prox
