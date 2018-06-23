local RemoveAfterTimeSystem = class("RemoveAfterTimeSystem", System)

function RemoveAfterTimeSystem:initialize()
    System.initialize(self)
end

function RemoveAfterTimeSystem:requires()
    return {"RemoveAfterTime"}
end

function RemoveAfterTimeSystem:update(dt)
    for _,e in pairs(self.targets) do
        local c = e:get("RemoveAfterTime")

        c.delay = c.delay - dt
        if c.delay <= 0 then
            prox.engine:removeEntity(e)
        end
    end
end

return RemoveAfterTimeSystem
