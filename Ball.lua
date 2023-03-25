local Object = require "class"
local Ball = Object:extend()

function Ball:new(x, y, width, height)
    -- Position of ball
    self.x = x
    self.y = y

    -- Size of ball
    self.width = width
    self.height = height

    -- Velocity of ball
    self.speed_y = math.random(2) == 1 and -100 or 100
    self.speed_x = math.random(-50, 50)
end

function Ball:reset()
    --  Reset position
    self.x = VIRTUAL_WIDTH/2 -2
    self.y = VIRTUAL_HEIGHT/2 -2

    -- Reset velocity
    self.speed_x = math.random(2) == 1 and -100 or 100
    self.speed_y = math.random(-50, 50)
end

function Ball:update(dt)
    -- Update position
    self.x = self.x + self.speed_x*dt
    self.y = self.y + self.speed_y*dt
end

function Ball:render()
    -- Draw ball
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )
end

return Ball
