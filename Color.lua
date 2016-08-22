local Color = class("prox.Color")

Color.static.WHITE = {255, 255, 255}
Color.static.BLACK = {0, 0, 0}
Color.static.RED = {255, 0, 0}
Color.static.GREEN = {0, 255, 0}
Color.static.BLUE = {0, 0, 255}
Color.static.GRAY = {128, 128, 128}

function Color:initialize(r, g, b, a)
	self._r = r
	self._g = g
	self._b = b
	self._a = a or 255
end

function Color:getRed()
	return self._r
end

function Color:getGreen()
	return self._g
end

function Color:getBlue()
	return self._b
end

function Color:getAlpha()
	return self._a
end

return Color
