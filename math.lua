local pmath = {}

function pmath.movetowards(x, y, step)
	if math.abs(x - y) <= step then
		return y
	end
	if x > y then
		return x - step
	else
		return x + step
	end
end

function pmath.movetowards2(x1, y1, x2, y2, step)
	local xdist = x2 - x1
	local ydist = y2 - y1
	local dist = math.sqrt(xdist^2 + ydist^2)
	if dist <= step then
		return x2, y2
	else
		return x1 + xdist/dist*step, y1 + ydist/dist*step
	end
end

function pmath.sign(x)
	if x < 0 then
		return -1
	else
		return 1
	end
end

function pmath.signz(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end

function pmath.round(x)
	return math.floor(x + 0.5)
end

function pmath.cap(x, a, b)
	return math.min(math.max(x, a), b)
end

function pmath.wrap(x, a, b)
	local y = x
	local dist = b - a + 1
	while y < a do
		y = y + dist
	end
	while y > b do
		y = y - dist
	end
	return y
end

function pmath.lerp(a, b, t)
	if t < 0 then return a end
	if t > 1 then return b end

	return (1 - t) * a + t * b
end

return pmath
