local window = {}

window._width = 1024
window._height = 768
window._scale = 1
window._fullscreen = false
window._vsync = true 
window._canvas = nil

function window.apply()
	love.window.setMode(
		window.getWidth() * window.getScale(),
		window.getHeight() * window.getScale(),
		{
			fullscreen = window.getFullscreen(),
			vsync = window.getVsync()
		}
	)
	canvas = love.graphics.newCanvas(window.getWidth(), window.getHeight())
end

function window.getWidth()
	return window._width
end

function window.getHeight()
	return window._height
end

function window.getSize()
	return window.getWidth(), window.getHeight()
end

function window.setSize(w, h)
	window._width = w
	window._height = h
	window.apply()
	canvas = love.graphics.newCanvas(window.getWidth(), window.getHeight())
end

function window.getScale()
	return window._scale
end

function window.setScale(s)
	window._scale = s
	window.apply()
end

function window.getFullscreen()
	return window._fullscreen
end

function window.setFullscreen(f)
	window._fullscreen = f
	window.apply()
end

function window.toggleFullscreen()
	window._fullscreen = not window._fullscreen
	window.apply()
end

function window.getVsync()
	return window._vsync
end

function window.setVsync(v)
	window._vsync = v
	window.apply()
end

function window.toggleVsync()
	window._vsync = not window._vsync
	window.apply()
end

function window.getCanvas()
	return canvas
end

return window
