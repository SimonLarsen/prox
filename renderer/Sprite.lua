local resources = require("prox.resources")
local Renderer = require("prox.renderer.Renderer")

local Sprite = class("prox.renderer.Sprite", Renderer)

function Sprite:initialize(path, ox, oy)
	Renderer.initialize(self)

	self._image = resources.getImage(path)

	self._ox = ox or self._image:getWidth() / 2
	self._oy = oy or self._image:getHeight() / 2
end

function Sprite:draw(x, y, z, r, sx, sy, ox, oy)
	love.graphics.draw(self._image, math.floor(x), math.floor(y), self._r+(r or 0), self._sx*(sx or 1), self._sy*(sy or 1), self._ox+(ox or 0), self._oy+(oy or 0))
end

return Sprite
