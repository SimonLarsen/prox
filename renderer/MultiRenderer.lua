local Renderer = require("prox.renderer.Renderer")

local MultiRenderer = class("prox.MultiRenderer", Renderer)

function MultiRenderer:initialize(...)
	Renderer.initialize(self)

	self._renderers = {}
	for i,v in ipairs({...}) do
		self:addRenderer(v)
	end
end

function MultiRenderer:draw(x, y, z)
	for i,v in ipairs(self._renderers) do
		if v:isVisible() then
			v:draw(x, y, z)
		end
	end
end

function MultiRenderer:update(dt)
	for i,v in ipairs(self._renderers) do
		v:update(dt)
	end
end

function MultiRenderer:addRenderer(renderer)
	table.insert(self._renderers, renderer)
end

function MultiRenderer:getRenderer(index)
	return self._renderers[index]
end

return MultiRenderer
