local Sprite = class("Sprite")

function Sprite:initialize(animation)
    self.image = prox.resources.getImage(animation.image)

    local imgw = self.image:getWidth()
    local imgh = self.image:getHeight()

    local xframes = animation.xframes or 1
    local yframes = animation.yframes or 1

    local fw = math.floor(imgw / xframes)
    local fh = math.floor(imgh / yframes)

    self.quads = {}
    for iy = 0, yframes-1 do
        for ix = 0, xframes-1 do
            local q = love.graphics.newQuad(ix*fw, iy*fh, fw, fh, imgw, imgh)
            table.insert(self.quads, q)
        end
    end

    self.frames = xframes * yframes
    self.delay = animation.delay or math.huge
    self.loop = animation.loop ~= false
    self.ox = animation.ox or (fw/2)
    self.oy = animation.oy or (fh/2)
    self.sx = animation.sx or 1
    self.sy = animation.sy or 1
    self.speed = 1

    self:reset()
end

function Sprite:reset()
    self.frame = 1
    self.time = 0
    self.finished = false
end

return Sprite
