local push = require "push"

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243

function love.load()
    love.graphics.setDefaultFilter(
        "nearest",
        "nearest"
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
    love.graphics.printf(
        "Hello Pong!",
        0,
        VIRTUAL_HEIGHT/2 - 6,
        VIRTUAL_WIDTH,
        "center"
    )
    push:apply("end")
end
