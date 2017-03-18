local Renderer = class("prox.Renderer")

function Renderer:initialize()
	self._r = 0
	self._sx = 1
	self._sy = 1
	self._ox = 0
	self._oy = 0

	self._visible = true
	self._shader = nil
end

function Renderer:isVisible()
	return self._visible
end

function Renderer:setVisible(visible)
	self._visible = visible
end

function Renderer:setRotation(r)
	self._r = r
end

function Renderer:getRotation()
	return self._r
end

function Renderer:setScale(sx, sy)
	self._sx = sx
	self._sy = sy or sx
end

function Renderer:getScale()
	return self._sx, self._sy
end

function Renderer:setOrigin(ox, oy)
	self._ox = ox
	self._oy = oy
end

function Renderer:getOrigin()
	return self._ox, self._oy
end

function Renderer:setShader(shader)
	self._shader = shader
end

function Renderer:getShader()
	return self._shader
end

-- Overloadable functions
function Renderer:draw(x, y, z, r, sx, sy, ox, oy) end
function Renderer:update(dt) end

return Renderer
