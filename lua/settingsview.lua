local class = require('pl.class')
local tablex = require('pl.tablex')
local vec3 = require("modules.vec3")
local mat4 = require("modules.mat4")
local pretty = require('pl.pretty')

class.SettingsView(ui.Cube)
function SettingsView:_init(bounds, clock)
    self:super(bounds)
    self.grabbable = true

    self:addSubview(ui.Label{
        bounds=ui.Bounds{size=ui.Size(1, 0.05, 0.05)}:move(0,0.18,0.051),
        text="Clock settings",
        color={0,0,0,1}
        --,text=,lineheight=,wrap=,halign=,color={r,g,b,a}}
    })

    local closeButton = self:addSubview(
        ui.Button(ui.Bounds{size=ui.Size(0.05,0.05,0.02)}:move( 0.23,0.22,0.031))
    )
    closeButton:setDefaultTexture(assets.quit)
    closeButton.onActivated = function()
        self:removeFromSuperview()
    end
end



return SettingsView
