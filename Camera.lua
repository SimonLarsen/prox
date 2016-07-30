local Camera = class("prox.Camera")

local window = require("prox.window")

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
	self._x = self._x + dx
	self._y = self._y + dy
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

function Camera:screenToWorld(x, y)
	return x/self:getZoom() + self:getX() - window.getWidth()/2/self:getZoom(),
	       y/self:getZoom() + self:getY() - window.getHeight()/2/self:getZoom()
end

function Camera:worldToScreen(x, y)
	return x * self:getZoom() - self:getX() + window.getWidth()/2/self:getZoom(),
	       y * self:getZoom() - self:getY() + window.getHeight()/2/self:getZoom()
end

return Camera
