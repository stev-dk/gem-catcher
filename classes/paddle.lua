local GameManager = require "classes.gameManager"
local Collision = require "classes.collision"

local Paddle = {
    sprite = nil,
    width = 0,
    height = 0,
    speed = 250,
    xPos = 0,
    yPos = 0,
    bottomOffset = 50
}
Paddle.__index = Paddle

function Paddle:draw()
    love.graphics.draw(self.sprite, self.xPos, self.yPos, math.deg(0), 1, 1)
end

function Paddle:load()
    self.sprite = love.graphics.newImage("assets/paddleBlu.png")
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
    self.xPos = GameManager:getScreenWidth() / 2 - (self.width / 2) -- center paddle
    self.yPos = GameManager:getScreenHeight() - self.bottomOffset
end

function Paddle:moveLeft(dt)
    if self.xPos > 0 then
        self.xPos = self.xPos - (self.speed * dt)
    end
end

function Paddle:moveRight(dt)
    if self.xPos < GameManager:getScreenWidth() - self.sprite:getWidth() then
        self.xPos = self.xPos + (self.speed * dt)
    end
end

function Paddle:movement(dt)
    if love.keyboard.isDown("left") then
        Paddle:moveLeft(dt)
    elseif love.keyboard.isDown("right") then
        Paddle:moveRight(dt)
    end
end

-- Move to Collision ??
function Paddle:update()
    for _,collision in pairs(Collision.collectibles) do
        if collision.xPos + collision.width > self.xPos and collision.xPos < self.xPos + self.width then
            collision:onCollected()
        end
    end
end

return Paddle
