local AnimatorSystem = class("AnimatorSystem", System)

function AnimatorSystem:initialize()
    System.initialize(self)
end

function AnimatorSystem:requires()
    return {"Animator"}
end

local function match_state(value, query)
	if type(query) == "string" then
		return value == query
	elseif type(query) == "table" then
		for i,v in ipairs(query) do
			if value == v then
				return true end
		end
		return false
	else
		error("Unknown state query. Must be string or table of strings.")
	end
end

local function change_state(entity, anim, state)
    anim.state = state
    anim.sprites[anim.state]:reset()
    entity:set(anim.sprites[anim.state])
    anim:setProperty("_finished", false)
end

function AnimatorSystem:update(dt)
    for _, e in pairs(self.targets) do
        local anim = e:get("Animator")
        if anim.default_state then
            change_state(e, anim, anim.default_state)
            anim.default_state = nil
        end

        for _, trans in pairs(anim.transitions) do
            if match_state(anim.state, trans.from) then
                local prop = anim.properties[trans.property]
                if trans.predicate and trans.predicate(prop.value, trans.value)
                or trans.predicate == nil and prop.value == trans.value then
                    change_state(e, anim, trans.to)
                end
            end
        end

        for _, prop in pairs(anim.properties) do
            if prop.trigger then
                prop.value = false
            end
        end

        if anim.sprites[anim.state].finished then
            anim:setProperty("_finished", true)
        end
    end
end

return AnimatorSystem
