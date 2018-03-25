local SpriteRenderer = class("prox.systems.graphics.SpriteRenderer", System)

function SpriteRenderer:initialize()
    System.initialize(self)
end

function SpriteRenderer:requires()
    return {"prox.components.graphics.Sprite", "prox.components.core.Transform"}
end

function SpriteRenderer:draw()
    for _,e in pairs(self.targets) do
        local t = e:get("prox.components.core.Transform")
        local sprite = e:get("prox.components.graphics.Sprite")

        love.graphics.draw(sprite.image, t.x, t.y, t.r, sprite.sx, sprite.sy, sprite.ox, sprite.oy)
    end
end

return SpriteRenderer
