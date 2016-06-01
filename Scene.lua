local window = require("prox.window")
local sort = require("prox.algorithm.sort")
local timer = require("prox.hump.timer")
local collision = require("prox.collision")
local Camera = require("prox.Camera")
local Entity = require("prox.Entity")

local Scene = class("prox.Scene")

function Scene:initialize(entities)
	self._entities = {}
	self._pending_entities = {}
	self._camera = Camera()
	self._hasEntered = false

	self._bgcolor = {0, 0, 0, 255}

	timer.clear()

	if entities then
		self:add(entities)
	end
end

function Scene:update(dt)
	-- Add pending entities
	for i,v in ipairs(self._pending_entities) do
		v._scene = self
		table.insert(self._entities, v)
	end

	for i,v in ipairs(self._pending_entities) do
		v:enter()
	end

	self._pending_entities = {}

	-- Update all entities
	for i,v in ipairs(self._entities) do
		if v:isAlive() then
			v:_update(dt)
		end
	end

	-- Do all vs. all collision detection
	self:_checkCollisions(dt, dt)

	-- Update all timers
	timer.update(dt)

	-- Sort entities based on z-coordinate
	sort.insertionsort(self._entities, function(a,b) return a.z > b.z end)

	-- Remove killed entities
	for i=#self._entities, 1, -1 do
		if self._entities[i]:isAlive() == false then
			self._entities[i]:onRemove()
			table.remove(self._entities, i)
		end
	end
end

function Scene:_checkCollisions(dt, rt)
	for i=1,#self._entities do
		for j=i+1,#self._entities do
			if collision.check(self._entities[i], self._entities[j]) then
				self._entities[i]:onCollide(self._entities[j], dt, rt)
				self._entities[j]:onCollide(self._entities[i], dt, rt)
			end
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

--- Add new Entity to scene.
function Scene:add(e)
	assert(type(e) == "table", "Argument to Scene:add() must be an Entity or table of entities.")
	if e.isInstanceOf and e:isInstanceOf(Entity) then
		table.insert(self._pending_entities, e)
	elseif type(e) == "table" then
		for i,v in ipairs(e) do
			self:add(v)
		end
	else
		error("Argument to Scene:add() must be an Entity or table of entities.")
	end
end

--- Removes all entities in scene.
function Scene:clear()
	for i,v in ipairs(self._entities) do
		v:remove()
	end
end

--- Returns first found entity matching given name.
function Scene:find(name)
	for i,v in ipairs(self._entities) do
		if v:getName() == name then
			return v
		end
	end
end

--- Returns table of all entities matching name.
function Scene:findAll(name)
	local t = {}
	for i,v in ipairs(self._entities) do
		if v:getName() == name then
			table.insert(t, v)
		end
	end
	return t
end

function Scene:getEntities()
	return self._entities
end

function Scene:getCamera()
	return self._camera
end

function Scene:setBackgroundColor(r, g, b, a)
	self._bgcolor = {r, g, b, a or 255}
end

function Scene:getBackgroundColor()
	return self._bgcolor
end

return Scene
