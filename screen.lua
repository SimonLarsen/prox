local screen = {}

screen._width = 1024
screen._height = 768
screen._scale = 1
screen._fullscreen = false

function screen.getWidth()
	return screen._width
end

function screen.getHeight()
	return screen._height
end

function screen.getSize()
	return screen.getWidth(), screen.getHeight()
end

function screen.setWidth(w)
	screen._width = w
end

function screen.setHeight(h)
	screen._height = h
end

function screen.setSize(w, h)
	screen.setWidth(w)
	screen.setHeight(h)
end

function screen.getScale()
	return screen._scale
end

function screen.setScale(s)
	screen._scale = s
end

function screen.isFullscreen()
	return screen._fullscreen
end

function screen.setFullscreen(f)
	screen._fullscreen = f
end

function screen.toggleFullscreen()
	screen._fullscreen = not screen._fullscreen
end

return screen
