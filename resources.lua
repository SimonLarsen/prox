local serialize = require("prox.serialize")

local resources = {}

local images = {}

function resources.getImage(path)
	if images[path] == nil then
		images[path] = love.graphics.newImage(path)
	end

	return images[path]
end

function resources.getAnimation(path)
	return serialize.read(path)
end

function resources.getAnimator(path)
	return serialize.read(path)
end

return resources
