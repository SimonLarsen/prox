local Renderer = class("prox.Renderer")

function Renderer:initialize()
	
end

-- Overloadable functions
function Renderer:draw(x, y, r, sx, sy) end
function Renderer:update(dt) end

return Renderer
