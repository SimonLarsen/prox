local Binding = class("prox.input.Binding")

function Binding:initialize()

end

-- Overloadable functions

function Binding:add(action, key) end
function Binding:wasPressed(action, consume) end
function Binding:isDown(action) end
function Binding:getAxis(name) end

return Binding
