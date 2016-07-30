local ptime = {}

function ptime.getTime()
	return love.timer.getTime()
end

function ptime.sleep(s)
	love.timer.sleep(s)
end

return ptime
