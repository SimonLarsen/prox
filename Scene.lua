local window = require("prox.window")
local sort = require("prox.algorithm.sort")
local timer = require("prox.hump.timer")
local Camera = require("prox.Camera")

local Scene = class("prox.Scene")

function Scene:initialize(entities)
	self._entities = {}
	self._camera = Camera()
	self._hasEntered = false

	self._bgcolor = {0, 0, 0, 255}

	timer.clear()

	for i,v in ipairs(entities) do
		table.insert(self._entities, v)
		v.scene = self
	end

	for i,v in ipairs(self._entities) do
		v:enter()
	end
end

function Scene:update(dt)
	for i,v in ipairs(self._entities) do
		if v:isAlive() then
			v:_update(dt)
		end
	end

	timer.update(dt)

	sort.insertionsort(self._entities, function(a,b) return a.z > b.z end)

	for i=#self._entities, 1, -1 do
		if self._entities[i]:isAlive() == false then
			self._entities[i]:onRemove()
			table.remove(self._entities, i)
		end
	end
end

function Scene:draw()
	love.graphics.push()

	-- Apply camera
	local w, h = window.getSize()
	love.graphics.translate(w/2 - self:getCamera():getX(), h/2 - self:getCamera():getY())
	love.graphics.scale(self:getCamera():getZoom())

	-- Draw entities
	for i,v in ipairs(self._entities) do
		v:_draw()
	end

	love.graphics.pop()
end

function Scene:gui()
	love.graphics.push()

	for i,v in ipairs(self._entities) do
		v:_gui()
	end

	love.graphics.pop()
end

function Scene:add(e)
	table.insert(self._entities, e)
	e.scene = self
	e:enter()
	return e
end

function Scene:find(name)
	for i,v in ipairs(self._entities) do
		if v:getName() == name then
			return v
		end
	end
end

function Scene:findAll(name)
	local t = {}
	for i,v in ipairs(self._entities) do
		if v:getName() == name then
			table.insert(t, v)
		end
	end
	return t
end

function Scene:clearEntities()
	self._entities = {}
end

function Scene:getEntities()
	return self._entities
end

function Scene:getCamera()
	return self._camera
end

function Scene:setBackgroundColor(r, g, b, a)
	self._bgcolor = {
		r or 0,
		g or 0,
		b or 0,
		a or 255
	}
end

function Scene:getBackgroundColor()
	return self._bgcolor
end

return Scene
