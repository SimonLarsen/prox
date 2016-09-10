local Binding = class("prox.input.Binding")

function Binding:initialize()

end

-- Overloadable functions
function Binding:add(action, key) end
function Binding:wasPressed(...) end
function Binding:wasReleased(...) end
function Binding:isDown(...) end
function Binding:getAxis(name) end

return Binding
