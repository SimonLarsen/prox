local mouse = require("prox.input.mouse")

local gui = {}

local default_buttons = {1}

local mouse_over_rect = function(x, y, w, h)
	local mx, my = mouse.getPosition()
	return mx >= x and mx < x+w and my >= y and my < y+h
end

local center_text = function(text, x, y, w, h)
	local texty = y + (h-love.graphics.getFont():getHeight())/2
	love.graphics.printf(text, x, texty, w, "center")
end

local gui_button_text = function(text, x, y, w, h)
	h = h or love.graphics.getFont():getHeight()
	w = w or love.graphics.getFont():getWidth(text)

	love.graphics.setColor(215, 215, 215)
	love.graphics.rectangle("fill", x, y, w, h)
	love.graphics.setColor(0, 0, 0)
	center_text(text, x, y, w, h)
	love.graphics.setColor(255, 255, 255)

	return x, y, w, h
end

local gui_button_image = function(image, x, y, w, h)
	w = w or image:getWidth()
	h = h or image:getHeight()

	local sx = w / image:getWidth()
	local sy = h / image:getHeight()

	love.graphics.draw(image, x, y, 0, sx, sy)

	return x, y, w, h
end

function gui.button(data, x, y, w, h, buttons)
	local hover = false
	local pressed = false
	local pressed_button

	buttons = buttons or default_buttons

	if type(data) == "userdata" then
		x, y, w, h = gui_button_image(data, x, y, w, h)
	else
		x, y, w, h = gui_button_text(data, x, y, w, h)
	end

	if mouse_over_rect(x, y, w, h) then
		hover = true
		for i,v in ipairs(buttons) do
			if mouse.wasPressed(v) then
				pressed = true
				pressed_button = v
				break
			end
		end
	end


	return pressed, pressed_button
end

return gui
