local GameManager = {}

GameManager.collectibles = {}
GameManager.lives = 5
GameManager.collectibleCount = 0
GameManager.collisionStart = 0
GameManager.collisionEnd = 0
GameManager.points = 0

local screenWidth = 0
local screenHeight = 0

function GameManager:loseLife(amount)
    self.lives = self.lives - amount
    if self.lives < 1 then
        self:restart()
    end
end

function GameManager:scorePoint(amount)
    self.points = self.points + amount
end

function GameManager:draw()
    love.graphics.print(string.format("Lives: %d", self.lives))
    love.graphics.print(string.format("Score: %d", self.points), screenWidth - 200, 0)
end

function GameManager:addCollectible(newCollectible)
    self.collectibleCount = self.collectibleCount + 1
    local collectibalId = "collectible_"..self.collectibleCount
    newCollectible:updateId(collectibalId)
    self.collectibles[collectibalId] = newCollectible
end

function GameManager:removeCollectible(oldCollectibleId)
    self.collectibles[oldCollectibleId] = nil
end

function GameManager:restart()
    love.load()
end

function GameManager:load()
    self.collectibles = {}
    self.lives = 5
    self.collectibleCount = 0
    self.points = 0
    self:setScreenHeight(love.graphics.getHeight())
    self:setScreenWidth(love.graphics.getWidth())
end

function GameManager:setScreenWidth(newScreenWidth)
    screenWidth = newScreenWidth
end

function GameManager:getScreenWidth()
    return screenWidth
end

function GameManager:setScreenHeight(newScreenHeight)
    screenHeight = newScreenHeight
end

function GameManager:getScreenHeight()
    return screenHeight
end

function GameManager:setCollisionVars(paddle)
    self.collisionStart = paddle.yPos
    self.collisionEnd = screenHeight - paddle.bottomOffset + paddle.height
end

return GameManager
