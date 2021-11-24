local class = require('pl.class')
local tablex = require('pl.tablex')
local vec3 = require("modules.vec3")
local mat4 = require("modules.mat4")
local pretty = require('pl.pretty')

class.SettingsView(ui.Cube)
function SettingsView:_init(bounds, clock)
    self:super(bounds)
    self.grabbable = true
    self.clock = clock
    self.color = ui.Color.alloLightGray()

    self:addSubview(ui.Label{
        bounds=ui.Bounds{size=ui.Size(bounds.size.width, 0.05, 0.05)}:move(0,0.18,0.051),
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

    self.tzLabel = self:addSubview(ui.Label{
        bounds=ui.Bounds{size=ui.Size(bounds.size.width, 0.05, 0.05)}:move(0.05, 0.08, 0.051),
        text="UTC+0",
        color={0,0,0,1},
        halign="left"
    })
    self.addButton = self:addSubview(
        ui.Button(ui.Bounds{size=ui.Size(0.10,0.10,0.05)}:move( 0.18,0.08,0.025))
    )
    self.addButton.label:setText("+")
    self.addButton.label.color = {0,0,0,1}
    self.addButton:setColor(ui.Color.alloDarkPink())
    self.addButton.onActivated = function()
        self.clock:setTimezoneOffset(self.clock.tzOffset + 30 * 60)
        self:updateLabel()
    end

    self.subButton = self:addSubview(
        ui.Button(ui.Bounds{size=ui.Size(0.10,0.10,0.05)}:move( 0.08,0.08,0.025))
    )
    self.subButton.label:setText("-")
    self.subButton.label.color = {0,0,0,1}
    self.subButton:setColor(ui.Color.alloDarkPink())
    self.subButton.onActivated = function()
        self.clock:setTimezoneOffset(self.clock.tzOffset - 30 * 60)
        self:updateLabel()    
    end
    self:updateLabel()
end

function SettingsView:updateLabel()
    local text = string.format("UTC%+.1f", self.clock.tzOffset/(60*60))
    self.tzLabel:setText(text)
end



return SettingsView
