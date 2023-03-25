local push = require "push"
local Ball = require "Ball"
local Paddle = require "Paddle"

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
PADDLE_SPEED = 200
FONT_FILE = "font.ttf"


function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if game_state == "start" then
            game_state = "play"
        else
            game_state = "start"

            ball:reset()
            
        end
    end
end


function love.load()
    game_state = "start"

    player_1_score, player_2_score = 0, 0

    player_1 = Paddle(10, 30, 5, 20)
    player_2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    small_font = love.graphics.newFont(
        FONT_FILE, 8
    )

    score_font = love.graphics.newFont(
        FONT_FILE, 32
    )

    math.randomseed(os.time())

    love.graphics.setFont(small_font)

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


function love.update(dt)
    if love.keyboard.isDown("w") then
        player_1.speed_y = -PADDLE_SPEED
    elseif love.keyboard.isDown("s") then
        player_1.speed_y = PADDLE_SPEED
    end

    if love.keyboard.isDown("up") then
        player_2.speed_y = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then
        player_2.speed_y = PADDLE_SPEED
    end
    
    if game_state == "play" then
        ball:update(dt)
    end

    player_1:update(dt)
    player_2:update(dt)
end


function love.draw()
    push:apply("start")

    love.graphics.clear(
        40/255,
        45/255,
        52/255,
        255/255
    )

    love.graphics.setFont(score_font)
    
    if game_state == "start" then
        love.graphics.printf(
            "Hello Pong!", 0,
            20, VIRTUAL_WIDTH,
            "center"
        )
    end

    love.graphics.print(
        tostring(player_1_score),
        VIRTUAL_WIDTH/2 - 50,
        VIRTUAL_HEIGHT/3
    )
    
    love.graphics.print(
        tostring(player_1_score),
        VIRTUAL_WIDTH/2 + 30,
        VIRTUAL_HEIGHT/3
    )

    player_1:render()
    player_2:render()

    ball:render()

    push:apply("end")
end
