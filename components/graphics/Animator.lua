local Animator = class("Animator")

function Animator:initialize(animator)
    self.state = nil
    self.default_state = animator.default
    self.states = animator.states
    self.properties = animator.properties or {}
    self.transitions = animator.transitions or {}

    self.sprites = {}
    for i, v in pairs(self.states) do
        if type(v) == "string" then
            self.sprites[i] = prox.Sprite(prox.resources.getAnimation(v))
        elseif type(v) == "table" then
            self.sprites[i] = prox.Sprite(prox.table.deep_copy(v))
        else
            error(string.format("Invalid value type for state \"%s\". Must be string or table.", i))
        end
    end

    self.properties["_finished"] = { value = false, trigger = true }
end

function Animator:setProperty(name, value)
    assert(self.properties[name], string.format("Property \"%s\" does not exist.", name))
    self.properties[name].value = value
end

return Animator
