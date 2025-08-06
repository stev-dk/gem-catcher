local collectibles = require "classes.collectibles"
local gameManager = require "classes.gameManager"

local gemSpawnInterval = 3
local gemSpawnTimer = 0

local function spawnTimer(dt)
    gemSpawnTimer = gemSpawnTimer + dt
    if gemSpawnTimer > gemSpawnInterval then
        gemSpawnTimer = gemSpawnTimer - gemSpawnInterval
        return true
    end
end

local function spawnGem()
    local Gem = collectibles.RedGem:new({gameManager = gameManager})
    Gem:load()
    table.insert(gameManager.collectibles, Gem)
end

function love.load()
    spawnGem()
end

function love.update(dt)
    for _, gem in ipairs(gameManager.collectibles) do
        gem:update(dt)
    end

    if spawnTimer(dt) then
        spawnGem()
    end
end

function love.draw()
    for _, gem in ipairs(gameManager.collectibles) do
        gem:draw()
        gameManager:draw()
    end
end
