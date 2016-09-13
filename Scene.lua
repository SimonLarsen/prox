local window = require("prox.window")
local sort = require("prox.algorithms.sort")
local timer = require("prox.hump.timer")
local collision = require("prox.collision")
local Camera = require("prox.Camera")
local Entity = require("prox.Entity")

local Scene = class("prox.Scene")

function Scene:initialize(entities)
	self._entities = {}
	self._camera = Camera()
	self._hasEntered = false

	self._bgcolor = {0, 0, 0, 255}
	self._speed = 1

	timer.clear()

	if entities then
		self:add(entities)
	end
end

function Scene:update(dt)
	-- Update all entities
	for i,v in ipairs(self._entities) do
		if v:isEnabled() then
			v:_update(dt*self._speed, dt)
		end
	end

	-- Do all vs. all collision detection
	self:_checkCollisions(dt, dt)

	-- Update all timers
	timer.update(dt)

	-- Sort entities based on z-coordinate
	sort.insertionsort(self._entities,
		function(a,b)
			return a.z == b.z and a.y < b.y or a.z > b.z
		end
	)

	-- Remove killed entities
	for i=#self._entities, 1, -1 do
		if self._entities[i]:isAlive() == false then
			self._entities[i]:onRemove()
			table.remove(self._entities, i)
		end
	end
end

function Scene:_checkCollisions(dt, rt)
	-- Check all vs all
	for i=1,#self._entities do
		for j=i+1,#self._entities do
			if collision.check(self._entities[i], self._entities[j]) then
				self._entities[i]:onCollide(self._entities[j], dt, rt)
				self._entities[j]:onCollide(self._entities[i], dt, rt)
			end
		end
	end

	-- Check mouse events
	local mx, my = prox.mouse.getWorldPosition()
	local mcx, mcy = prox.mouse.getPosition()
	for i,v in ipairs(self._entities) do
		if collision.contains(v, mx, my) then
			if not v._mouse_over then v:onMouseEnter() end

			for button=1,3 do
				if prox.mouse.wasPressed(button) then
					v:onMouseDown(mcx, mcy, button)
				end
				if prox.mouse.wasReleased(button) then
					v:onMouseUp(mcx, mcy, button)
				end
			end

			v._mouse_over = true
		else
			if v._mouse_over then v:onMouseExit() end
			v._mouse_over = false
		end
	end
end

function Scene:draw()
	love.graphics.push()

	-- Apply camera
	local w, h = window.getSize()
	local zoom = self:getCamera():getZoom()
	love.graphics.translate(
		window.getWidth()/2 - math.floor(self:getCamera():getX())*zoom,
		window.getHeight()/2 - math.floor(self:getCamera():getY())*zoom
	)
	love.graphics.scale(self:getCamera():getZoom())

	-- Draw entities
	for i,v in ipairs(self._entities) do
		if v:isEnabled() then
			v:_draw()
		end
	end

	love.graphics.pop()
end

function Scene:gui()
	love.graphics.push()

	for i,v in ipairs(self._entities) do
		if v:isEnabled() then
			v:_gui()
		end
	end

	love.graphics.pop()
end

--- Add new Entity to scene.
function Scene:add(e)
	assert(type(e) == "table", "Argument to Scene:add() must be an Entity or table of entities.")
	if e.isInstanceOf and e:isInstanceOf(Entity) then
		table.insert(self._entities, e)
		e._scene = self
		if e._init_args then
			e:enter(unpack(e._init_args))
		else
			e:enter()
		end
		e._init_args = nil
		e._has_entered = true
	elseif type(e) == "table" then
		for i,v in ipairs(e) do
			self:add(v)
		end
	else
		error("Argument to Scene:add() must be an Entity or table of entities.")
	end
	return e
end

--- Removes all entities in scene.
function Scene:clear()
	for i,v in ipairs(self._entities) do
		if v.keepAlive == nil or not v.keepAlive() then
			v:remove()
		end
	end
end

function Scene:find(name)
	if type(name) == "string" then
		for i,v in ipairs(self._entities) do
			if v:getName() == name then
				return v
			end
		end
	elseif type(name) == "table" then
		for i,v in ipairs(self._entities) do
			if v:isInstanceOf(name) then
				return v
			end
		end
	else
		error("Cannot search entity with object of type " .. type(name))
	end
end

function Scene:findAll(name)
	local t = {}
	if type(name) == "string" then
		for i,v in ipairs(self._entities) do
			if v:getName() == name then
				table.insert(t, v)
			end
		end
	elseif type(name) == "table" then
		for i,v in ipairs(self._entities) do
			if v:isInstanceOf(name) then
				table.insert(t, v)
			end
		end
	else
		error("Cannot search entities with object of type " .. type(name))
	end
	return t
end

function Scene:setSpeed(s)
	self._speed = s
end

function Scene:getSpeed()
	return self._speed
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

function Scene:sendMessage(method, ...)
	for i,v in ipairs(self:getEntities()) do
		if v[method] and type(v[method]) == "function" then
			v[method](v, ...)
		end
	end
end

return Scene
