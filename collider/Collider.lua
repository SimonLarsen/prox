local Collider = class("prox.collider.Collider")

function Collider:initialize(type)
	self._type = type
end

function Collider:getType()
	return self._type
end

return Collider
