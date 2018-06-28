local Camera = class("Camera")

function Camera:initialize(main, zoom)
    self.main = main ~= false
    self.zoom = zoom or 1
end

return Camera
