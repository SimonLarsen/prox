local SpriteRenderer = class("SpriteRenderer", System)

function SpriteRenderer:initialize()
    System.initialize(self)
end

function SpriteRenderer:requires()
    return {"Sprite", "Transform"}
end

function SpriteRenderer:update(dt)
    for _, e in pairs(self.targets) do
        s = e:get("Sprite")
        s.time = s.time + dt * s.speed
        if s.time >= s.delay then
            s.time = s.time - s.delay
            s.frame = s.frame + 1
            if s.frame > s.frames then
                s.finished = true
                if s.loop then
                    s.frame = 1
                else
                    s.frame = s.frames
                end
            end
        end
    end
end

function SpriteRenderer:draw()
    local sorted = {}
    for i,v in pairs(self.targets) do
        table.insert(sorted, v)
    end
    table.sort(sorted, function(a, b) return a:get("Transform").z > b:get("Transform").z end)

    local _r, _g, _b, _a = love.graphics.getColor()

    for _,e in pairs(sorted) do
        local t = e:get("Transform")
        local sprite = e:get("Sprite")

        love.graphics.setColor(sprite.color)
        love.graphics.draw(sprite.image, sprite.quads[sprite.frame], math.floor(t.x+0.5), math.floor(t.y+0.5), t.r, sprite.sx, sprite.sy, sprite.ox, sprite.oy)
    end

    love.graphics.setColor(_r, _g, _b, _a)
end

return SpriteRenderer
