local window = {}

local width = 1024
local height = 768
local scale = 1
local fullscreen = false
local fullscreen_mode = "scale" -- options: "scale", "fill" and "stretch"
local vsync = true
local canvas = nil
local canvas_x = 0
local canvas_y = 0
local canvas_sx = 1
local canvas_sy = 1
local max_delta = 1/10

local update_canvas = function()
	canvas = love.graphics.newCanvas(window.getWidth(), window.getHeight())
end

function window.apply()
	if window.getFullscreen() then
		local desktop_width, desktop_height = love.window.getDesktopDimensions()

		if fullscreen_mode == "scale" then
			canvas_x = math.floor((desktop_width - width*window.getScale())/2)
			canvas_y = math.floor((desktop_height - height*window.getScale())/2)
			canvas_sx, canvas_sy = window.getScale(), window.getScale()
		elseif fullscreen_mode == "fill" then
			local sc = math.min(desktop_width / width, desktop_height / height)
			canvas_x = math.floor((desktop_width - width*sc)/2)
			canvas_y = math.floor((desktop_height - height*sc)/2)
			canvas_sx = sc
			canvas_sy = sc
		elseif fullscreen_mode == "stretch" then
			canvas_x, canvas_y = 0, 0
			canvas_sx = desktop_width / width
			canvas_sy = desktop_height / height
		end
	else
		canvas_x, canvas_y = 0, 0
		canvas_sx, canvas_sy = window.getScale(), window.getScale()
	end

	love.window.setMode(
		window.getWidth() * window.getScale(),
		window.getHeight() * window.getScale(),
		{
			fullscreen = window.getFullscreen(),
			vsync = window.getVsync()
		}
	)
	update_canvas()
end

function window.getWidth()
	return width
end

function window.getHeight()
	return height
end

function window.getSize()
	return window.getWidth(), window.getHeight()
end

function window.setSize(w, h)
	width = w
	height = h
	window.apply()
	update_canvas()
end

function window.getScale()
	return scale
end

function window.setScale(s)
	scale = s
	window.apply()
end

function window.getFullscreen()
	return fullscreen
end

function window.setFullscreen(f)
	fullscreen = f
	window.apply()
end

function window.toggleFullscreen()
	fullscreen = not fullscreen
	window.apply()
end

function window.getFullscreenMode()
	return fullscreen_mode
end

function window.setFullscreenMode(mode)
	assert(mode == "scale" or mode == "fill" or mode == "stretch", "Unrecognized fullscreen mode. Options are: \"scale\", \"fill\" or \"stretch\"")
	fullscreen_mode = mode
	window.apply()
end

function window.toggleFullscreenMode()
	if fullscreen_mode == "scale" then fullscreen_mode = "fill"
	elseif fullscreen_mode == "fill" then fullscreen_mode = "stretch"
	else fullscreen_mode = "scale"
	end
	window.apply()
end

function window.getVsync()
	return vsync
end

function window.setVsync(v)
	vsync = v
	window.apply()
end

function window.toggleVsync()
	vsync = not vsync
	window.apply()
end

function window._getCanvas()
	return canvas
end

function window._getCanvasParams()
	return canvas_x, canvas_y, 0, canvas_sx, canvas_sy
end

function window.setMaxDelta(m)
	max_delta = m
end
function window._getMaxDelta()
	return max_delta
end

return window
