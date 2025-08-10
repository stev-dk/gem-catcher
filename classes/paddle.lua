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

    -- DEBUG
    local offset = -25
    for _,collision in pairs(Collision.collectibles) do
        love.graphics.print(collision.collectibleId, self.xPos, self.yPos + offset)
        offset = offset - 15
    end
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

function Paddle:update()
    for _,collision in pairs(Collision.collectibles) do

        if collision.xPos + collision.width > self.xPos and collision.xPos < self.xPos + self.width then
            collision:playCollectSound()
            GameManager:scorePoint(collision.points)
            GameManager:removeCollectible(collision.collectibleId)
            Collision:removeCollectibleCollision(collision.collectibleId)
        end
    end
end

return Paddle
