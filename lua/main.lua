local vec3 = require("modules.vec3")
local mat4 = require("modules.mat4")
local ClockView = require("clockview")

local client = Client(
    arg[2], 
    "allo-clock"
)
local app = App(client)
local assets = {
    quit = ui.Asset.File("images/quit.png"),
}
app.assetManager:add(assets)


local mainView = ui.Surface(ui.Bounds(0, 1.2, -2,   1, 1.2, 0.01))
mainView.grabbable = true

local clock = mainView:addSubview(ClockView(ui.Bounds()))

local quitButton = mainView:addSubview(
    ui.Button(ui.Bounds{size=ui.Size(0.12,0.12,0.05)}:move( 0.52,0.62,0.025))
)
quitButton:setDefaultTexture(assets.quit)
quitButton.onActivated = function()
    app:quit()
end

app.mainView = mainView
app:connect()
app:run()
