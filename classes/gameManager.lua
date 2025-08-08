GameManager = {}

GameManager.collectibles = {}
GameManager.lives = 5
GameManager.collectibalCount = 0

local screenWidth = 0
local screenHeight = 0

function GameManager:loseLife(amount)
    self.lives = self.lives - amount
    if self.lives < 1 then
        self:restart()
    end
end

function GameManager:draw()
    love.graphics.print(string.format("Lives: %d", self.lives))
end

function GameManager:addCollectible(newCollectible)
    self.collectibalCount = self.collectibalCount + 1
    local collectibalId = "collectible_"..self.collectibalCount
    newCollectible:updateId(collectibalId)
    self.collectibles[collectibalId] = newCollectible
end

function GameManager:removeCollectible(oldCollectibleId)
    self.collectibles[oldCollectibleId] = nil
end

function GameManager:restart()
    GameManager.collectibles = {}
    GameManager.lives = 5
    GameManager.collectibalCount = 0
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

return GameManager
