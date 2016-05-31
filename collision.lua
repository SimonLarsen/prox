local collision = {}

function collision.check(a, b)
	if a:getCollider() == nil or b:getCollider() == nil then
		return false
	end

	if a:getCollider():getType() == "box" and b:getCollider():getType() == "box" then
		return collision.checkBoxBox(a, b)
	else
		error(string.format("Checking collision between \"%s\" and \"%s\" not supported.", a:getCollider():getType(), b:getCollider():getType()))
	end
end

function collision.checkBoxBox(a, b)
	local ac = a:getCollider()
	local bc = b:getCollider()

	if math.abs((a.x + ac:getOffsetX()) - (b.x + bc:getOffsetX())) > (ac:getWidth() + bc:getWidth())/2
	or math.abs((a.y + ac:getOffsetY()) - (b.y + bc:getOffsetY())) > (ac:getHeight() + bc:getHeight())/2 then
		return false
	end

	return true
end

return collision
