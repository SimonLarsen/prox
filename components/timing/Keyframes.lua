local Keyframes = class("Keyframes")

function Keyframes:initialize()
    self.curves = {}
end

function Keyframes:add(id, target, field, points, loop, play)
    local t = {
        time = 0,
        active = false,
        loop = loop == true,
        target = target,
        field = field,
        points = points,
    }
    self.curves[id] = t

    if play then
        self:play(id)
    end
end

function Keyframes:play(id)
    self.curves[id].active = true
    self.curves[id].time = 0
end

return Keyframes
