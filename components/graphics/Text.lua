local Text = class("Text")

function Text:initialize(text)
    self.text = text.text
    self.width = text.width
    self.align = text.align or "center"
    self.ox = text.ox or 0
    self.oy = text.oy or 0
    self.r = text.r or 0
    self.sx = text.sx or 1
    self.sy = text.sy or 1
    self.color = text.color or {1,1,1,1}
end

return Text
