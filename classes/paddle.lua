Paddle = {
    sprite = nil,
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
    self.xPos = GameManager:getScreenWidth() / 2 - (self.sprite:getWidth() / 2) -- center paddle
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

return Paddle
