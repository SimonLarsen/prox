local Entity = class("prox.Entity")

function Entity:initialize(name, x, y, z, r, sx, sy)
	self._name = name
	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
	self.r = r or 0
	self.sx = sx or 1
	self.sy = sy or 1

	self._scene = nil
	self._collider = nil
	self._alive = true
	self._renderer = nil
end

function Entity:_update(dt, rt)
	if self._renderer then
		self._renderer:update(dt)
	end

	self:update(dt, rt)
end

function Entity:_draw()
	if self._renderer then
		self._renderer:draw(self.x, self.y, self.z, self.r, self.sx, self.sy)
	end

	self:draw()
end

function Entity:_gui()
	self:gui()
end

function Entity:setName(name)
	self._name = name
end

function Entity:getName()
	return self._name
end

function Entity:kill()
	self._alive = false
end

function Entity:isAlive()
	return self._alive
end

function Entity:setCollider(collider)
	self._collider = collider
end

function Entity:getCollider()
	return self._collider
end

function Entity:getScene()
	return self._scene
end

function Entity:setRenderer(renderer)
	self._renderer = renderer
end

function Entity:getRenderer()
	return self._renderer
end

-- Overloable functions

--- Called when entity is created.
function Entity:enter() end

--- Update function called every frame.
-- @param dt Delta time in game time since last update.
-- @param rt Delta time in real time since last update.
function Entity:update(dt, rt) end

--- Draw entity.
function Entity:draw() end

--- Draw GUI elements.
function Entity:gui() end

--- Called when entity is removed from scene.
function Entity:onRemove() end

--- Called when collides with other entity.
-- @param o Colliding entity.
-- @param dt Delta time in game time.
-- @param rt Delta time in real time.
function Entity:onCollide(o, dt, rt) end

return Entity
