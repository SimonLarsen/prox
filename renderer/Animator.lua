local resources = require("prox.resources")
local Renderer = require("prox.renderer.Renderer")
local Animation = require("prox.renderer.Animation")

local Animator = class("prox.renderer.Animator", Renderer)

function Animator:initialize(path)
	Renderer.initialize(self)

	local animator = resources.getAnimator(path)

	self._transitions = animator.transitions

	self._animations = {}
	for i,v in pairs(animator.states) do
		self._animations[i] = Animation(v)
	end

	self._properties = {}
	for i,v in pairs(animator.properties) do
		assert(i ~= "_finished", "\"_finished\" is a reserved property name.")
		self._properties[i] = {
			value = v.value,
			isTrigger = v.isTrigger or false,
			predicate = v.predicate
		}
	end
	self._properties["_finished"] = { value = false, isTrigger = true }

	self._state = animator.default
	self._animations[self._state]:reset()
end

function Animator:update(dt)
	for i,v in pairs(self._transitions) do
		if v.from == self._state then
			local prop = self._properties[v.property]
			if (v.predicate and v.predicate(prop.value, v.value))
			or (v.predicate == nil and prop.value == v.value) then
				self._state = v.to
				self._animations[self._state]:reset()
				break
			end
		end
	end

	for i,v in pairs(self._properties) do
		if v.isTrigger == true then
			v.value = false
		end
	end

	self._animations[self._state]:update(dt)
	if self._animations[self._state]:isFinished() then
		self:setProperty("_finished", true)
	end
end

function Animator:draw(x, y, z)
	self._animations[self._state]:draw(x, y, z, self._r, self._sx, self._sy, self._ox, self._oy)
end

function Animator:setProperty(name, value)
	assert(self._properties[name], string.format("Property \"%s\" does not exist.", name))
	self._properties[name].value = value
end

return Animator
