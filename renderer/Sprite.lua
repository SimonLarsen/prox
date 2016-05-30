local resources = require("prox.resources")
local Renderer = require("prox.renderer.Renderer")

local Sprite = class("prox.renderer.Sprite", Renderer)

function Sprite:initialize(path, ox, oy)
	self._image = resources.getImage(path)

	local imgw = self._image:getWidth()
	local imgh = self._image:getHeight()

	self._ox = ox or self._image:getWidth() / 2
	self._oy = oy or self._image:getHeight() / 2
end

function Sprite:draw(x, y, z, r, sx, sy)
	love.graphics.draw(self._image, x, y, r, sx, sy, self._ox, self._oy)
end

function Sprite:setOrigin(ox, oy)
	self._ox = ox
	self._oy = oy
end

return Sprite
