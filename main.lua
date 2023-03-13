local push = require "push"


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

            ball_x, ball_y = VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2

            ball_speed_x = math.random(2) == 1 and 100 or -100
            ball_speed_y = math.random(-50, 50)*1.5
            
        end
    end
end


function love.load()
    game_state = "start"

    player_1_score, player_2_score = 0, 0

    player_1_y, player_2_y = 30, VIRTUAL_HEIGHT - 50

    ball_x, ball_y = VIRTUAL_WIDTH/2 - 2, VIRTUAL_HEIGHT/2 - 2
    
    ball_speed_x = math.random(2) == 1 and 100 or -100

    ball_speed_y = math.random(-50, 50)

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
        player_1_y = player_1_y - PADDLE_SPEED*dt
    elseif love.keyboard.isDown("s") then
        player_1_y = player_1_y + PADDLE_SPEED*dt
    end

    if love.keyboard.isDown("up") then
        player_2_y = player_2_y - PADDLE_SPEED*dt
    elseif love.keyboard.isDown("down") then
        player_2_y = player_2_y + PADDLE_SPEED*dt
    end
    
    if game_state == "play" then
        ball_x = ball_x + ball_speed_x*dt
        ball_y = ball_y + ball_speed_y*dt
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

    love.graphics.rectangle(
        "fill",
        10,
        player_1_y,
        5, 20
    )
    
    love.graphics.rectangle(
        "fill",
        VIRTUAL_WIDTH - 10,
        player_2_y - 50,
        5, 20
    )

    love.graphics.rectangle(
        "fill",
        ball_x,
        ball_y,
        4, 4
    )


    push:apply("end")
end
