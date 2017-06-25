local serialize = require("prox.serialize")

local resources = {}

local images = {}
local fonts = {}
local sounds = {}
local shaders = {}

function resources.getImage(path)
	if images[path] == nil then
		assert(love.filesystem.exists(path), "Image file \"" .. path .. "\" not found.")
		images[path] = love.graphics.newImage(path)
	end

	return images[path]
end

function resources.getAnimation(path)
	assert(love.filesystem.exists(path), "Animation file \"" .. path .. "\" not found.")
	return serialize.read(path)
end

function resources.getAnimator(path)
	assert(love.filesystem.exists(path), "Animator file \"" .. path .. "\" not found.")
	return serialize.read(path)
end

function resources.getFont(path, size)
	local key = path .. "$" .. size
	if fonts[key] == nil then
		assert(love.filesystem.exists(path), "Font file \"" .. path .. "\" not found.")
		fonts[key] = love.graphics.newFont(path, size)
	end

	return fonts[key]
end

function resources.getImageFont(path, glyphs, spacing)
	if fonts[path] == nil then
		assert(love.filesystem.exists(path), "Image font file \"" .. path .. "\" not found.")
		fonts[path] = love.graphics.newImageFont(path, glyphs, spacing or 2)
	end
	return fonts[path]
end

function resources.getSound(path)
	if sounds[path] == nil then
		assert(love.filesystem.exists(path), "Sound file \"" .. path .. "\" not found.")
		sounds[path] = love.audio.newSource(path, "static")
	end
	return sounds[path]
end

function resources.getShader(path)
	if shaders[path] == nil then
		assert(love.filesystem.exists(path), "Shader file \"" .. path .. "\" not found.")
		shaders[path] = love.graphics.newShader(path)
	end
	return shaders[path]
end

return resources
