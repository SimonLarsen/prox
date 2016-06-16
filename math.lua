local pmath = {}

function pmath.movetowards(x, y, dt)
	if math.abs(x - y) <= dt then
		return y
	end
	if x > y then
		return x - dt
	else
		return x + dt
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

function pmath.lerp(a, b, t)
	if t < 0 then return a end
	if t > 1 then return b end

	return (1 - t) * a + t * b
end

return pmath
