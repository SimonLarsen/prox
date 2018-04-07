local SpriteRenderer = class("SpriteRenderer", System)

function SpriteRenderer:initialize()
    System.initialize(self)
end

function SpriteRenderer:requires()
    return {"Sprite", "Transform"}
end

function SpriteRenderer:draw()
    local sorted = {}
    for i,v in pairs(self.targets) do
        table.insert(sorted, v)
    end
    table.sort(sorted, function(a, b) return a:get("Transform").z > b:get("Transform").z end)

    for _,e in pairs(sorted) do
        local t = e:get("Transform")
        local sprite = e:get("Sprite")

        love.graphics.draw(sprite.image, math.floor(t.x+0.5), math.floor(t.y+0.5), t.r, sprite.sx, sprite.sy, sprite.ox, sprite.oy)
    end
end

return SpriteRenderer
