local Color = require("prox.Color")

local GUIStyle = class("prox.gui.GUIStyle")

function GUIStyle:initialize()
    self.normal = {bg = { 66, 66, 66}, fg = {188,188,188}}
    self.hover  = {bg = { 50,153,187}, fg = {255,255,255}}
    self.active = {bg = {255,153,  0}, fg = {225,225,225}}
	self.font = love.graphics.newFont(10)
	self.align = "center"
	self.border = 0
	self.radius = 0
end

return GUIStyle
