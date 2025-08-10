local collectiblesClass = require "classes.collectibles"

local GameManager = {}

GameManager.collectibles = {}
GameManager.lives = 5
GameManager.collectibleCount = 0
GameManager.collisionStart = 0
GameManager.collisionEnd = 0
GameManager.points = 0

local bgImage = love.graphics.newImage("assets/GameBg.png")
local screenWidth = 0
local screenHeight = 0
local backgroundMusic = love.audio.newSource("assets/bgm_action_5.mp3", "stream")
local collectibleSpawnInterval = 1
local collectibleSpawnTimer = 0

local function spawnTimer(dt)
    collectibleSpawnTimer = collectibleSpawnTimer + dt
    if collectibleSpawnTimer > collectibleSpawnInterval then
        collectibleSpawnTimer = collectibleSpawnTimer - collectibleSpawnInterval
        return true
    end
end

local function spawnRedGem(self)
    local RedGem = collectiblesClass.RedGem:new({gameManager = self})
    RedGem:load()
    self:addCollectible(RedGem)
end

function GameManager:addCollectible(newCollectible)
    self.collectibleCount = self.collectibleCount + 1
    local collectibalId = "collectible_"..self.collectibleCount
    newCollectible:updateId(collectibalId)
    self.collectibles[collectibalId] = newCollectible
end

function GameManager:drawBackground()
    love.graphics.draw(bgImage, 0, 0)
end

function GameManager:drawUI()
    love.graphics.print(string.format("Lives: %d", self.lives))
    love.graphics.print(string.format("Score: %d", self.points), screenWidth - 200, 0)
end

function GameManager:drawCollectibles()
    for _, collectible in pairs(self.collectibles) do
        collectible:draw()
    end
end

function GameManager:getScreenHeight()
    return screenHeight
end

function GameManager:getScreenWidth()
    return screenWidth
end

function GameManager:load()
    self.collectibles = {}
    self.lives = 5
    self.collectibleCount = 0
    self.points = 0
    self:setScreenHeight(love.graphics.getHeight())
    self:setScreenWidth(love.graphics.getWidth())
    collectibleSpawnInterval = 1
    collectibleSpawnTimer = 0
    -- Background Music
    love.audio.stop()
    love.audio.play(backgroundMusic)
    backgroundMusic:setLooping(true)
end

function GameManager:loseLife(amount)
    self.lives = self.lives - amount
    if self.lives < 1 then
        self:restart()
    end
end

function GameManager:removeCollectible(oldCollectibleId)
    self.collectibles[oldCollectibleId] = nil
end

function GameManager:restart()
    love.load()
end

function GameManager:scorePoint(amount)
    self.points = self.points + amount
end

function GameManager:setScreenWidth(newScreenWidth)
    screenWidth = newScreenWidth
end

function GameManager:setScreenHeight(newScreenHeight)
    screenHeight = newScreenHeight
end

function GameManager:setCollisionVars(paddle)
    self.collisionStart = paddle.yPos
    self.collisionEnd = screenHeight - paddle.bottomOffset + paddle.height
end

function GameManager:spawnGems(dt)
    if spawnTimer(dt) then
        spawnRedGem(self)
    end
end

function GameManager:updateCollectibles(dt)
    for _, collectible in pairs(self.collectibles) do
        collectible:update(dt)
    end
end

return GameManager
