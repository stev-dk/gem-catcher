GameManager = require "classes.gameManager"
Paddle = require "classes.paddle"

local collectibles = require "classes.collectibles"

local collectibleSpawnInterval = 1
local collectibleSpawnTimer = 0

-- Refactor, outsource this function?
local function spawnTimer(dt)
    collectibleSpawnTimer = collectibleSpawnTimer + dt
    if collectibleSpawnTimer > collectibleSpawnInterval then
        collectibleSpawnTimer = collectibleSpawnTimer - collectibleSpawnInterval
        return true
    end
end

-- Refactor -- outsource this function?
local function spawnRedGem()
    local RedGem = collectibles.RedGem:new()
    RedGem:load()
    GameManager:addCollectible(RedGem)
end

function love.load()
    GameManager:setScreenWidth(love.graphics.getWidth())
    GameManager:setScreenHeight(love.graphics.getHeight())
    Paddle:load()
    spawnRedGem()
end

function love.update(dt)
    for _, collectible in pairs(GameManager.collectibles) do
        collectible:update(dt)
    end

    if spawnTimer(dt) then
        spawnRedGem()
    end

    -- Refactor to function, movement. Maybe inside paddle.lua?
    if love.keyboard.isDown("left") then
        Paddle:moveLeft(dt)
    elseif love.keyboard.isDown("right") then
        Paddle:moveRight(dt)
    end
end

function love.draw()
    for _, collectible in pairs(GameManager.collectibles) do
        collectible:draw()
    end
    GameManager:draw()
    Paddle:draw()
end
