local push = require "push"

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243

function love.load()
    love.graphics.setDefaultFilter(
        "nearest", "nearest"
    )

    push:setupScreen(
        VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
        WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = false,
            vsync = true
    })
end

function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    end
end

function love.draw()
    push:apply("start")

    love.graphics.clear(
        40/255,
        45/255,
        52/255,
        255/255
    )

    love.graphics.printf(
        "Hello Pong!", 0,
        20, VIRTUAL_WIDTH,
        "center"
    )

    love.graphics.rectangle(
        "fill",
        10, 30,
        5, 20
    )
    
    love.graphics.rectangle(
        "fill",
        VIRTUAL_WIDTH - 10,
        VIRTUAL_HEIGHT - 50,
        5, 20
    )

    love.graphics.rectangle(
        "fill",
        VIRTUAL_WIDTH/2 - 2,
        VIRTUAL_HEIGHT/2 - 2,
        4, 4
    )

    push:apply("end")
end
