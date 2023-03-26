-- Imports
local push = require "push"
local Ball = require "Ball"
local Paddle = require "Paddle"


-- Constat variables
WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
PADDLE_SPEED = 200
FONT_FILE = "font.ttf"


-- set title window
love.window.setTitle("Pong Game by Carlos_San")


function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if game_state == "start" then
            game_state = "serve"
        elseif game_state == "serve" then
            game_state = "play"
        elseif game_state == "done" then
            game_state = "serve"

            ball:reset()

            player_1_score = 0
            player_2_score = 0

            if winner == 1 then
                serving_player = 2
            else
                serving_player = 1
            end
        end
    end
end


function love.load()
    math.randomseed(os.time())

    game_state = "start"

    serving_player = math.random(1, 2)

    player_1_score, player_2_score = 0, 0

    player_1 = Paddle(10, 30, 5, 20)
    player_2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    small_font = love.graphics.newFont(
        FONT_FILE, 8
    )

    large_font = love.graphics.newFont(
        FONT_FILE, 26
    )


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
    else
        player_1.speed_y = 0
    end

    if love.keyboard.isDown("up") then
        player_2.speed_y = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then
        player_2.speed_y = PADDLE_SPEED
    else
        player_2.speed_y = 0
    end
    if game_state == "serve" then
        ball.speed_y = math.random(50,-50)
        if serving_player == 1 then
            ball.speed_x = math.random(140, 200)
        else
            ball.speed_x = -math.random(140, 200)
        end
    elseif game_state == "play" then
        if ball:collides(player_1) then
            ball.speed_x = -ball.speed_x*1.03
            ball.x = player_1.x + 5
            
            if ball.speed_y < 0 then
                ball.speed_y = -math.random(10, 150)
            else
                ball.speed_y = math.random(10, 150)
            end
        end

        if ball:collides(player_2) then
            ball.speed_x = -ball.speed_x*1.03
            ball.x = player_2.x - 4
            
            if ball.speed_y < 0 then
                ball.speed_y = -math.random(10, 150)
            else
                ball.speed_y = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.speed_y = -ball.speed_y
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.speed_y = -ball.speed_y
        end

        if ball.x < 0 then
            serving_player = 1
            player_2_score = player_2_score + 1

            if player_2_score == 7 then
                winner = 2
                game_state = "done"
            else
                game_state = "serve"
                ball:reset()
            end
        end
    
        if ball.x > VIRTUAL_WIDTH then
            serving_player = 2
            player_1_score = player_1_score + 1
            if player_1_score == 7 then
                winner = 1
                game_state = "done"
            else
                game_state = "serve"
                ball:reset()
            end
        end

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
    
    love.graphics.setFont(large_font)
    
    displayScore()
    if game_state == "start" then
        love.graphics.setFont(small_font)
        love.graphics.printf(
            "Hello Pong!",
            0, 20, VIRTUAL_WIDTH,
            "center"
        )
        love.graphics.printf(
            "Press Enter to start!",
            0, 10, VIRTUAL_WIDTH,
            "center"
        )
    elseif game_state == "serve" then
        love.graphics.setFont(small_font)
        love.graphics.printf(
            "Player "..tostring(serving_player).."'s serve!",
            0, 10, VIRTUAL_WIDTH,
            "center"
        )
        love.graphics.printf(
            "Press Enter to serve!",
            0, 20, VIRTUAL_WIDTH,
            "center"
        )
    elseif game_state == "play" then
    elseif game_state == "done" then
        love.graphics.setFont(large_font)
        love.graphics.printf(
            "Player "..tostring(winner).." wins!",
            0, 10, VIRTUAL_WIDTH,
            "center"
        )
        love.graphics.printf(
            "Press Enter to restart!",
            0, 30, VIRTUAL_WIDTH,
            "center"
        )
    end
    
    player_1:render()
    player_2:render()
    
    ball:render()

    displayFPS()
    
    push:apply("end")
end


function displayFPS()
    love.graphics.setFont(small_font)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print(
        "FPS: "..tostring(love.timer.getFPS()),
        10,
        10
    )
end

function displayScore()
    love.graphics.print(
        tostring(player_1_score),
        VIRTUAL_WIDTH/2 - 50,
        VIRTUAL_HEIGHT/3
    )
    
    love.graphics.print(
        tostring(player_2_score),
        VIRTUAL_WIDTH/2 + 30,
        VIRTUAL_HEIGHT/3
    )
end