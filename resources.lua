local serialize = require("prox.serialize")

local images = {}
local fonts = {}
local sounds = {}
local shaders = {}

local resources = {}

function resources.exists(path)
    return love.filesystem.getInfo(path) ~= nil
end

function resources.getImage(path)
	if images[path] == nil then
		assert(resources.exists(path), "Image file \"" .. path .. "\" not found.")
		images[path] = love.graphics.newImage(path)
	end

	return images[path]
end

function resources.getAnimation(path)
	assert(resources.exists(path), "Animation file \"" .. path .. "\" not found.")
	return serialize.read(path)
end

function resources.getAnimator(path)
	assert(resources.exists(path), "Animator file \"" .. path .. "\" not found.")
	return serialize.read(path)
end

function resources.getFont(path, size)
	local key = path .. "$" .. size
	if fonts[key] == nil then
		assert(resources.exists(path), "Font file \"" .. path .. "\" not found.")
		fonts[key] = love.graphics.newFont(path, size)
	end

	return fonts[key]
end

resources.setFont = love.graphics.setFont

function resources.getImageFont(path, glyphs, spacing)
	if fonts[path] == nil then
		assert(resources.exists(path), "Image font file \"" .. path .. "\" not found.")
		fonts[path] = love.graphics.newImageFont(path, glyphs, spacing or 2)
	end
	return fonts[path]
end

function resources.getSound(path)
	if sounds[path] == nil then
		assert(resources.exists(path), "Sound file \"" .. path .. "\" not found.")
		sounds[path] = love.audio.newSource(path, "static")
	end
	return sounds[path]
end

function resources.getShader(path)
	if shaders[path] == nil then
		assert(resources.exists(path), "Shader file \"" .. path .. "\" not found.")
		shaders[path] = love.graphics.newShader(path)
	end
	return shaders[path]
end

return resources
