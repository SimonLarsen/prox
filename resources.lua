local serialize = require("prox.serialize")

local resources = {}

local images = {}
local fonts = {}

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

function resources.getFont(path, size)
	local key = path .. "$" .. size
	if fonts[key] == nil then
		fonts[key] = love.graphics.newFont(path, size)
	end

	return fonts[key]
end

return resources
