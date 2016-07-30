local resources = require("prox.resources")
local Renderer = require("prox.renderer.Renderer")

local Sprite = class("prox.renderer.Sprite", Renderer)

function Sprite:initialize(path, ox, oy)
	Renderer.initialize(self)

	self._image = resources.getImage(path)

	self.ox = ox or self._image:getWidth() / 2
	self.oy = oy or self._image:getHeight() / 2
end

function Sprite:draw(x, y, z)
	love.graphics.draw(self._image, x, y, self.r, self.sx, self.sy, self.ox, self.oy)
end

return Sprite
