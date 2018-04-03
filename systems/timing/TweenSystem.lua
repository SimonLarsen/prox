local TweenSystem = class("TweenSystem", System)

function TweenSystem:initialize()
    System.initialize(self)
end

function TweenSystem:requires()
    return {"Tween"}
end

function TweenSystem:update(dt)
    for _,e in pairs(self.targets) do
        local t = e:get("Tween")

        for i=#t.tweens, 1, -1 do
            local complete = t.tweens[i]:update(dt)
            if complete then
                table.remove(t.tweens, i)
            end
        end
    end
end

return TweenSystem
