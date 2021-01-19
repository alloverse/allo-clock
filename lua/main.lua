local vec3 = require("modules.vec3")
local mat4 = require("modules.mat4")

local client = Client(
    arg[2], 
    "allo-clock"
)
local app = App(client)

local mainView = ui.Surface(ui.Bounds(0, 1.2, -2,   1, 1.2, 0.01))
mainView.grabbable = true


for i=1,12 do
    local indicator = ui.Cube(
        ui.Bounds{size=ui.Size((i % 3 == 0) and 0.05 or 0.025, 0.10, 0.05)}
        :move( 0, 0.4, 0)
        :rotate((6.28/12)*i, 0,0,1)
        :move( 0, 0.1, 0)
    )
    mainView:addSubview(indicator)
end

local hoursArm = ui.Cube(
    ui.Bounds{size=ui.Size(0.075, 0.20, 0.05)}
)
mainView:addSubview(hoursArm)

local minutesArm = ui.Cube(
    ui.Bounds{size=ui.Size(0.035, 0.30, 0.05)}
)
mainView:addSubview(minutesArm)

local secondsArm = ui.Cube(
    ui.Bounds{size=ui.Size(0.01, 0.30, 0.05)}
)
mainView:addSubview(secondsArm)

local digitalTime = ui.Label{
    bounds=ui.Bounds{size=ui.Size(1, 0.15, 0.05)}:move(0,-0.45,0.01),
    text="12:34:56",
    color={0,0,0,1}
    --,text=,lineheight=,wrap=,halign=,color={r,g,b,a}}
}
mainView:addSubview(digitalTime)

function updateTime()
    local date = os.date("*t")
    
    local m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.14, 0))
    mat4.rotate(m, m, date.hour * 6.28/24, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    hoursArm:setTransform(m)

    m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.24, 0))
    mat4.rotate(m, m, date.min * 6.28/60, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    minutesArm:setTransform(m)

    m = mat4.identity()
    mat4.translate(m, m, vec3(0, 0.24, 0))
    mat4.rotate(m, m, date.sec * 6.28/60, vec3(0, 0, -1))
    mat4.translate(m, m, vec3(0, 0.1, 0))
    secondsArm:setTransform(m)

    digitalTime:setText(os.date("%H:%M:%S"))
end

app:scheduleAction(1.0, true, updateTime)
updateTime()


local quitButton = ui.Button(ui.Bounds{size=ui.Size(0.12,0.12,0.05)}:move( 0.52,0.62,0.025))
quitButton:setDefaultTexture("iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABHNCSVQICAgIfAhkiAAABUtJREFUeJztm+1TGlcUxp9dcEEQ1wFl7VjT5sXMRE3SWmOssUkax6oBtNM/r39DJ8bXWKNJG3XaRGPbqJlpY0zrS+sC4cUFFYHdfohaQMC9cLc6kOfj7p5nz/l593Dv3pX5dvapgiLVxMoy2JNO4qQ0sbIMAMUJ4KB4oAgBJBYPFBmA1OKBIgKQrnigSABkKh4oAgDZigcKHMBxxQMFDEBN8UCBAlBbPFCAAEiKBwB9LjfZDEm5hGmuRbdIHFNwI4BU7wFoaa4PhaAPBDNfoHYhrmi3YtcMQEkgAKF/EMLQCHThcPqLmON9TCtv8MF398Du7NJNcF+aAODcHlT3D0AvSdBLEuxDI2AjEWKf0r9WUTk+Ac7jhTAwqAkE6gCM6xuoHhxOSpbz+WEfeQAmFiPyqRobByPLhx7CwCB04W2q+VIFYF5+DWHkAZi9vSPnDJsi7GPjwH5B2WT4ZxP20TEw8XjScc7nR3X/fZQEs/QVQlEDYFl6icqHk0BK0okyrq6hcvJx+ua3f4xzu2EfHs04WvRbEoR7A+A8XgpZUwLAz83D+uOUqm5tfrUM68zM0RMM3j3rQ6Ngo9GsHrqdHQj3B2HY+DvXlA+VNwBdeBvlLxaIYiwvFsHPzScdK/H5IAyrb5ZsNApheBTGPCHkBCDx7xw3m+B2dEMuKSHyqHg2C8vSSwBASTAIYXCEuMtHbTbs2auIYlJF5RGICAI83Z1QWDI765NpWBaWYB8Yhm6brLvvVdoguu4Sg08VtSa4W1sLb2cHWZCiwDo1DX0oRBQWtVohupyQDQay+6VR/gASnoft8+fgu9met2U2RXkeossBudRIxS9vAErKdFZqbECwpTlf27SKlVsg9rkQN5uoeWoyFQ40fwbpciNVz1hZGcReF+JlZqq+mi2GfO03EK67QMUrbjLB3edErNxCxS9R2i2HGcDb8SV2z9TmZSOXGiH2OhDleUqJJUvbFyIsC3f3Vzn/VssGA0SXE1GrlXJi/0n7N0IsC5njcgqN2KuwZ7NRTihZ2gKQZVR+/xDG9Y2cwkvX1mGdmqacVLK0A6AoqJx4BNObP/OysSwuoWL2OZ2c0kgbAApge/QDzMuvqdjxs3OwLCxS8UoVfQCKAtuTKZT9/gdVW+vUDMyvyDY91Ig6AOvMTyjbX+XRlm3yMYyra1Q9qQKo+PkpLITvBkjEyDLsY+PgRDc1T2oAKuaeg5//lSyIYbB99mOykFgMwvAoOL+f7F4ZRAVA+S+/gX82Rxznb2uFp6cLW1evEMWxkQiqhkahl/Lfo6QCQDZwAKNilyNBgdbrh4X721oRvlhHFK8PhWBZzL/X5AQgtdRQ/SV4ujoBnU5VfLC5CcGmTxIMGXjv3MbOR2dU5yBdaYS/9brq6zMp7xFwAGP73FmIzh4ox0x7tz69ikDLtTSZsPB0dSJSXX3sPQMt1+Brv6Fqa+04Uf0V2K2pwWafE/HS0rTnpcuN8H/emjFe0evhdnQjasuw+GEY+G59gWBzE410AWgwD9irqoL4TR/i5uQXF6H6S/C1tx0b/24F6Di69tfp4O3sgNRQTzNdbabCUZ6H+LXrEEL4Yh3e3rqpulHGTSa4XY7DkaRwHERHD8IXzlPPVbPF0AEEqbEBb+/cJn5eozwPt/MuYuXl2Ox1YvfDGi3SBJPL/wv8n98IMbKser+hIL8RIt1sIdWpB6C13gM46QROWjl9KJlLszmtIh4BpJ+innYRASi04gECAIVYPKCiBxRq4QfKOgIKvXggC4BiKB7IAKBYigfSACim4oGEJlhshR+IBYq3eAD4FzLNyUTM0XqEAAAAAElFTkSuQmCC")
quitButton.onActivated = function()
    app:quit()
end
mainView:addSubview(quitButton)

app.mainView = mainView
app:connect()
app:run()