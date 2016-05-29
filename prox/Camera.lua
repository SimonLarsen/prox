local Camera = class("prox.Camera")

function Camera:initialize(x, y, zoom)
	self._x = x or 0
	self._y = y or 0
	self._zoom = zoom or 1
end

function Camera:setPosition(x, y)
	self._x = x
	self._y = y
end

function Camera:move(dx, dy)
	self._x = self.x + dx
	self._y = self.y + dy
end

function Camera:setX(x)
	self._x = x
end

function Camera:getX()
	return self._x
end

function Camera:setY(y)
	self._y = y
end

function Camera:getY()
	return self._y
end

function Camera:setZoom(zoom)
	self._zoom = zoom
end

function Camera:getZoom()
	return self._zoom
end

return Camera
