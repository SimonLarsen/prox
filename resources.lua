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

function resources.getImageFont(path, glyphs, spacing)
	if fonts[path] == nil then
		fonts[path] = love.graphics.newImageFont(path, glyphs, spacing or 2)
	end
	return fonts[path]
end

return resources
