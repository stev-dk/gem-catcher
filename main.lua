GameManager = require "classes.gameManager"

local collectibles = require "classes.collectibles"

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
    local Gem = collectibles.RedGem:new()
    Gem:load()
    table.insert(GameManager.collectibles, Gem)
end

function love.load()
    spawnGem()
end

function love.update(dt)
    for _, gem in ipairs(GameManager.collectibles) do
        gem:update(dt)
    end

    if spawnTimer(dt) then
        spawnGem()
    end
end

function love.draw()
    for _, gem in ipairs(GameManager.collectibles) do
        gem:draw()
        GameManager:draw()
    end
end
