local Car = require( "car" )
local world = display.newGroup()

local camera = require( "2DCamera.camera" ).new
{
    view = world,
    trackingSpeed = 0.05,
    maxVelocity = 10
}

-- Concrete texture sourced from here - https://freestocktextures.com/texture/grey-concrete-wall,960.html
local concrete = display.newImage( world, "concrete.jpg", 0, 0 )

local focusCar = 1
local cars = {}

cars[ #cars + 1 ] = Car.new
{
    parent = world,
    playerIndex = #cars + 1,
    x = math.random( 100, display.contentWidth - 100 ),
    y = math.random( 100, display.contentHeight - 100 ),
    rotation = math.random( 360 ),
    isSmoothingDisabled = camera.isSmoothingDisabled(),
    controls = { go = "up", stop = "down", left = "left", right = "right", reallyStop = "space", zoomIn = "x", zoomOut = "c" }
}

cars[ #cars + 1 ] = Car.new
{
    parent = world,
    playerIndex = #cars + 1,
    x = math.random( 100, display.contentWidth - 100 ),
    y = math.random( 100, display.contentHeight - 100 ),
    rotation = math.random( 360 ),
    isSmoothingDisabled = camera.isSmoothingDisabled(),
    controls = { go = "w", stop = "s", left = "a", right = "d", reallyStop = "z", zoomIn = "x", zoomOut = "c" }
}


local onEnterFrame = function( event )
    camera.update( 1 )

    local focus = cars[ focusCar ].getCameraFocus()
    camera.focusOn( focus.x, focus.y, focus.zoom, focus.rotation )

end
Runtime:addEventListener( "enterFrame", onEnterFrame )

local onKey = function( event )

    if event.phase == "down" and cars[ tonumber( event.keyName ) ] then
        focusCar = tonumber( event.keyName )
    end

end
Runtime:addEventListener( "key", onKey )
