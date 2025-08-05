local collectibles = require "classes.collectibles"

local gemSpawnInterval = 3
local gemSpawnTimer = 0

local collectiblesArray = {}

local function spawnGem(dt)
    gemSpawnTimer = gemSpawnTimer + dt
    if gemSpawnTimer > gemSpawnInterval then
        gemSpawnTimer = gemSpawnTimer - gemSpawnInterval
        return true
    end
end

function love.load()
    Gem = collectibles.RedGem:new()
    Gem:load()
    table.insert(collectiblesArray, Gem)
end

function love.update(dt)
    for _, gem in ipairs(collectiblesArray) do
        gem:update(dt)
    end

    -- Refactor?
    if spawnGem(dt) then
        local Gem = collectibles.RedGem:new()
        Gem:load()
        table.insert(collectiblesArray, Gem)
    end
end

function love.draw()
    for _, gem in ipairs(collectiblesArray) do
        gem:draw()
    end
end
