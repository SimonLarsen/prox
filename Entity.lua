local Entity = class("prox.Entity")

function Entity:initialize(...)
	self._name = ""
	self.x = 0
	self.y = 0
	self.z = 0

	self._init_args = {...}
	self._has_entered = false
	self._mouse_over = false
	self._scene = nil
	self._collider = nil
	self._alive = true
	self._enabled = true
	self._renderer = nil
	self._stay_alive = false
end

function Entity:_update(dt, rt)
	self:update(dt, rt)

	if self._renderer then
		self._renderer:update(dt)
	end
end

function Entity:_draw()
	if self._renderer and self._renderer:isVisible() then
		love.graphics.setShader(self._renderer:getShader())
		self._renderer:draw(self.x, self.y, self.z)
		love.graphics.setShader()
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

function Entity:setEnabled(e)
	self._enabled = e
end

function Entity:isEnabled()
	return self._enabled
end

--- Remove entity from scene.
function Entity:remove()
	self._enabled = false
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

--- Get scene entity belongs to.
function Entity:getScene()
	return self._scene
end

--- Set renderer object for entity.
-- Call without argument to remove renderer.
function Entity:setRenderer(renderer)
	self._renderer = renderer
end

function Entity:getRenderer()
	return self._renderer
end

function Entity:setPosition(x, y)
	self.x, self.y = x, y
end

function Entity:move(dx, dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

function Entity:keepAlive()
	return false
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

--- Called when entity collides with other entity.
-- @param o Colliding entity.
-- @param dt Delta time in game time.
-- @param rt Delta time in real time.
function Entity:onCollide(o, dt, rt) end

function Entity:onMouseDown(x, y, button) end
function Entity:onMouseUp(x, y, button) end
function Entity:onMouseEnter() end
function Entity:onMouseExit() end

return Entity
