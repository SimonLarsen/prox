local Renderer = require("prox.renderer.Renderer")

local MultiRenderer = class("prox.MultiRenderer", Renderer)

function MultiRenderer:initialize(...)
	Renderer.initialize(self)

	self._renderers = {}
	self._offsetx = {}
	self._offsety = {}
	for i,v in ipairs({...}) do
		self:addRenderer(v)
	end
end

function MultiRenderer:draw(x, y, z)
	for i,v in ipairs(self._renderers) do
		if v:isVisible() then
			v:draw(x + self._offsetx[i], y + self._offsety[i], z)
		end
	end
end

function MultiRenderer:update(dt)
	for i,v in ipairs(self._renderers) do
		v:update(dt)
	end
end

function MultiRenderer:addRenderer(renderer, offsetx, offsety)
	table.insert(self._renderers, renderer)
	table.insert(self._offsetx, offsetx or 0)
	table.insert(self._offsety, offsety or 0)
end

function MultiRenderer:setOffset(index, offsetx, offsety)
	self._offsetx[index] = offsetx
	self._offsety[index] = offsety
end

function MultiRenderer:getRenderer(index)
	return self._renderers[index]
end

return MultiRenderer
