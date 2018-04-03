local Tween = class("Tween")

function Tween:initialize()
    self.tweens = {}
end

function Tween:add(...)
    table.insert(self.tweens, prox.tween.new(...))
end

function Tween:clear()
    self.tweens = {}
end

return Tween
