GameManager = require "classes.gameManager"

local collectibles = require "classes.collectibles"

local gemSpawnInterval = 3
local gemSpawnTimer = 0
local gemCounter = 0

-- Refactor, outsource this function?
local function spawnTimer(dt)
    gemSpawnTimer = gemSpawnTimer + dt
    if gemSpawnTimer > gemSpawnInterval then
        gemSpawnTimer = gemSpawnTimer - gemSpawnInterval
        return true
    end
end

-- Refactor -- outsource this function?
-- Refactor GameManager to handle the gemId ?
local function spawnGem()
    gemCounter = gemCounter + 1
    local gemId = "gem"..gemCounter
    local Gem = collectibles.RedGem:new({gemId = gemId})
    Gem:load()
    GameManager:addGem(Gem, gemId)
end

function love.load()
    spawnGem()
end

function love.update(dt)
    for _, gem in pairs(GameManager.collectibles) do
        gem:update(dt)
    end

    if spawnTimer(dt) then
        spawnGem()
    end
end

function love.draw()
    for _, gem in pairs(GameManager.collectibles) do
        gem:draw()
        GameManager:draw()
    end
end
