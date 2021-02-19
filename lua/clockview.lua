local class = require('pl.class')
local tablex = require('pl.tablex')
local vec3 = require("modules.vec3")
local mat4 = require("modules.mat4")
local pretty = require('pl.pretty')

class.ClockView(ui.View)
function ClockView:_init(bounds)
    self:super(bounds)

    self.hoursArm = self:addSubview(ui.Cube(
        ui.Bounds{size=ui.Size(0.075, 0.20, 0.05)}
    ))
    self.minutesArm = self:addSubview(ui.Cube(
        ui.Bounds{size=ui.Size(0.035, 0.30, 0.05)}
    ))
    self.secondsArm = self:addSubview(ui.Cube(
        ui.Bounds{size=ui.Size(0.01, 0.30, 0.05)}
    ))
    self.digitalTime = self:addSubview(ui.Label{
        bounds=ui.Bounds{size=ui.Size(1, 0.15, 0.05)}:move(0,-0.45,0.01),
        text="12:34:56",
        color={0,0,0,1}
        --,text=,lineheight=,wrap=,halign=,color={r,g,b,a}}
    })

    self:updateTime()
end

function ClockView:awake()
    View.awake(self)
    for i=1,12 do
        local indicator = ui.Cube(
            ui.Bounds{size=ui.Size((i % 3 == 0) and 0.05 or 0.025, 0.10, 0.05)}
            :move( 0, 0.4, 0)
            :rotate((6.28/12)*i, 0,0,1)
            :move( 0, 0.1, 0)
        )
        self.app:scheduleAction(0.05*(12-i), false, function()
            self:addSubview(indicator)
        end)
    end

    self.app:scheduleAction(1.0, true, function() self:updateTime() end)
end

function ClockView:updateTime()
    local date = os.date("*t")
    
    local m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.14, 0))
    mat4.rotate(m, m, date.hour * 6.28/12 + (date.min * 6.28/60)/12, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    self.hoursArm:setTransform(m)

    m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.24, 0))
    mat4.rotate(m, m, date.min * 6.28/60, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    self.minutesArm:setTransform(m)

    m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.24, 0))
    mat4.rotate(m, m, date.sec * 6.28/60, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    self.secondsArm:setTransform(m)

    self.digitalTime:setText(os.date("%H:%M:%S"))
end

return ClockView
