local Sprite = class("Sprite")

function Sprite:initialize(image, ox, oy, sx, sy)
	self.image = image
	self.ox = ox or math.floor(self.image:getWidth() / 2)
	self.oy = oy or math.floor(self.image:getHeight() / 2)
    self.sx = sx or 1
    self.sy = sy or 1
end

return Sprite
