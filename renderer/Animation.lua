local resources = require("prox.resources")
local Renderer = require("prox.renderer.Renderer")

local Animation = class("prox.renderer.Animation", Renderer)

function Animation:initialize(path)
	Renderer.initialize(self)

	local animation = resources.getAnimation(path)

	self._image = resources.getImage(animation.image)

	local imgw = self._image:getWidth()
	local imgh = self._image:getHeight()

	local fw = animation.fw
	local fh = animation.fh

	local xframes = math.floor(imgw / fw)
	local yframes = math.floor(imgh / fh)

	self._quads = {}
	for iy = 0, yframes-1 do
		for ix = 0, xframes-1 do
			local q = love.graphics.newQuad(ix*fw, iy*fh, fw, fh, imgw, imgh)
			table.insert(self._quads, q)
		end
	end

	self._frames = xframes * yframes
	self._delay = animation.delay
	self.ox = animation.ox or (fw/2)
	self.oy = animation.oy or (fh/2)
	self._speed = 1

	self:reset()
end

function Animation:update(dt, entity)
	self._time = self._time + dt * self._speed
	if self._time >= self._delay then
		self._time = 0
		self._frame = self._frame + 1
		if self._frame > self._frames then
			self._frame = 1
			self._finished = true
		end
	end
end

function Animation:reset()
	self._frame = 1
	self._time = 0
	self._finished = false
end

function Animation:draw(x, y, z)
	love.graphics.draw(self._image, self._quads[self._frame], math.floor(x), math.floor(y), self.r, self.sx, self.sy, self.ox, self.oy)
end

function Animation:setSpeed(speed)
	self._speed = speed
end

function Animation:setOrigin(ox, oy)
	self._ox = ox
	self._oy = oy
end

function Animation:isFinished()
	return self._finished
end

return Animation
