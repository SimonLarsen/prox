local Renderer = class("prox.Renderer")

function Renderer:initialize()
	self.r = 0
	self.sx = 1
	self.sy = 1
	self.ox = 0
	self.oy = 0

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

function Renderer:setShader(shader)
	self._shader = shader
end

function Renderer:getShader()
	return self._shader
end

-- Overloadable functions
function Renderer:draw(x, y, z) end
function Renderer:update(dt) end

return Renderer
