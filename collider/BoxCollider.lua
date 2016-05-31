local Collider = require("prox.collider.Collider")

local BoxCollider = class("prox.collider.BoxCollider", Collider)

function BoxCollider:initialize(w, h, ox, oy)
	Collider.initialize(self, "box")
	
	self._width = w
	self._height = h
	self._ox = ox or 0
	self._oy = oy or 0
end

function BoxCollider:getWidth()
	return self._width
end

function BoxCollider:getHeight()
	return self._height
end

function BoxCollider:getOffsetX()
	return self._ox
end

function BoxCollider:getOffsetY()
	return self._oy
end

return BoxCollider
