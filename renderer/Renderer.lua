local Renderer = class("prox.Renderer")

function Renderer:initialize()
	self._visible = true

	self.r = 0
	self.sx = 1
	self.sy = 1
	self.ox = 0
	self.oy = 0
end

function Renderer:isVisible()
	return self._visible
end

function Renderer:setVisible(visible)
	self._visible = visible
end

function Renderer:setRotation(r)
	self.r = r
end

function Renderer:setScale(sx, sy)
	self.sx = sx
	self.sy = sy or sx
end

function Renderer:setOrigin(ox, oy)
	self.ox = ox
	self.oy = oy
end

-- Overloadable functions
function Renderer:draw(x, y, z) end
function Renderer:update(dt) end

return Renderer
