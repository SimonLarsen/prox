local GUIStyle = require("prox.gui.GUIStyle")
local mouse = require("prox.input.mouse")

local gui = {}

local default_buttons = {1}
local style = nil
local quads = {}

local mouse_over_rect = function(x, y, w, h)
	local mx, my = mouse.getPosition()
	return mx >= x and mx < x+w and my >= y and my < y+h
end

local center_text = function(text, x, y, w, h)
	local texty = math.floor(y + (h-style.font:getHeight())/2)
	love.graphics.setFont(style.font)
	love.graphics.printf(text, x, texty, w, "center")
end

local gui_button_size = function(data, x, y, w, h)
	if type(data) == "userdata" then
		w = w or image:getWidth()
		h = h or image:getHeight()
	else
		h = h or style.font:getHeight()
		w = w or style.font:getWidth(data)
	end

	return x, y, w, h
end

local gui_button_text = function(text, x, y, w, h, hover, active)
	if active then
		love.graphics.setColor(style.active.bg)
	elseif hover then
		love.graphics.setColor(style.hover.bg)
	else
		love.graphics.setColor(style.normal.bg)
	end

	if style.radius > 0 then
		love.graphics.rectangle("fill", x, y, w, h, style.radius, style.radius, 16)
	else
		love.graphics.rectangle("fill", x, y, w, h)
	end

	if active then
		love.graphics.setColor(style.active.fg)
	elseif hover then
		love.graphics.setColor(style.hover.fg)
	else
		love.graphics.setColor(style.normal.fg)
	end

	center_text(text, x, y, w, h)

	if style.border > 0 then
		love.graphics.setLineWidth(style.border)
		love.graphics.rectangle("line", x+0.5, y+0.5, w, h)
	end

	love.graphics.setColor(255, 255, 255, 255)
end

function gui.setStyle(s)
	assert(s:isInstanceOf(GUIStyle), "Bad argument #1. Expected prox.gui.GUIStyle.")
	style = s
end

function gui.getStyle()
	return style
end

function gui.rectangle(x, y, w, h)
	love.graphics.setColor(style.normal.bg)
	if style.radius > 0 then
		love.graphics.rectangle("fill", x, y, w, h, style.radius, style.radius, 16)
	else
		love.graphics.rectangle("fill", x, y, w, h)
	end
	love.graphics.setColor(255, 255, 255, 255)
end

function gui.image(image, x, y, w, h)
	w = w or image:getWidth()
	h = h or image:getHeight()

	local sx = w / image:getWidth()
	local sy = h / image:getHeight()

	love.graphics.draw(image, x, y, 0, sx, sy)
end

function gui.button(data, x, y, w, h, buttons)
	local hover = false
	local pressed = false
	local pressed_button

	buttons = buttons or default_buttons

	x, y, w, h = gui_button_size(data, x, y, w, h)

	local hover = mouse_over_rect(x, y, w, h)
	local active = false

	if hover then
		for i,v in ipairs(buttons) do
			if mouse.isDown(v) then
				active = true
			end

			if mouse.wasPressed(v) then
				pressed = true
				pressed_button = v
				break
			end
		end
	end

	if type(data) == "userdata" then
		gui.image(data, x, y, w, h)
	else
		gui_button_text(data, x, y, w, h, hover, active)
	end

	return pressed, pressed_button
end

function gui.label(text, x, y, w)
	love.graphics.setFont(style.font)
	love.graphics.printf(text, x, y, w, style.align)
end

return gui
