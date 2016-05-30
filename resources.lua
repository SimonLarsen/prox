local resources = {}

local images = {}

function resources.getImage(path)
	if images[path] == nil then
		images[path] = love.graphics.newImage(path)
	end

	return images[path]
end

function resources.getAnimation(path)
	local f = love.filesystem.load(path)
	return f()
end

function resources.getAnimator(path)
	local f = love.filesystem.load(path)
	return f()
end

return resources
