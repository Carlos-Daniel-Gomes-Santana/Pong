local Object = require "class"
local Paddle = Object:extend()

function Paddle:new(x, y, width, height)
    -- Position of paddle
    self.x = x
    self.y = y

    -- Size of paddle
    self.width = width
    self.height = height

    -- Velocity of paddle
    self.speed_y = 0
end

function Paddle:update(dt)
    -- Update position
    if self.speed_y < 0 then
        self.y = math.max(
            0,
            self.y + self.speed_y*dt
        )
    else
        self.y = math.min(
            VIRTUAL_HEIGHT - self.height,
            self.y + self.speed_y*dt
        )
    end
end

function Paddle:render()
    -- Draw ball
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )
end

return Paddle
