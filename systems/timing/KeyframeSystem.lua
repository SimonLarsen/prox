local KeyframeSystem = class("KeyframeSystem", System)

function KeyframeSystem:initialize()
    System.initialize(self)
end

function KeyframeSystem:requires()
    return {"Keyframes"}
end

function KeyframeSystem:update(dt)
    for _,e in pairs(self.targets) do
        local keyframes = e:get("Keyframes")

        for _,k in pairs(keyframes.curves) do
            if k.active then
                k.time = k.time + dt

                local i = 1
                while i < #k.points do
                    if k.time >= k.points[i].time and k.time < k.points[i+1].time then
                        break
                    end
                    i = i+1
                end

                local target = e:get(k.target)

                if i < #k.points then
                    local t = (k.time - k.points[i].time) / (k.points[i+1].time - k.points[i].time)
                    target[k.field] = prox.math.lerp(k.points[i].value, k.points[i+1].value, t)
                else
                    target[k.field] = k.points[i].value
                    if k.loop then
                        k.time = 0
                    else
                        k.active = false
                    end
                end
            end
        end
    end
end

return KeyframeSystem
