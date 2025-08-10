local GameManager = require "classes.gameManager"
local Paddle = require "classes.paddle"
local collectibles = require "classes.collectibles"
local collision  = require "classes.collision"

local collectibleSpawnInterval = 1
local collectibleSpawnTimer = 0

local bgImage = nil
local bgSound = nil

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
    bgImage = love.graphics.newImage("assets/GameBg.png")
    bgSound = love.audio.newSource("assets/bgm_action_5.mp3", "stream")
    love.audio.stop()
    love.audio.play(bgSound)

    GameManager:load()
    collision:resetCollisions()
    Paddle:load()
    GameManager:setCollisionVars(Paddle)
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

    Paddle:update()
end

function love.draw()
    love.graphics.draw(bgImage, 0, 0)
    for _, collectible in pairs(GameManager.collectibles) do
        collectible:draw()
    end
    GameManager:draw()
    Paddle:draw()
end
