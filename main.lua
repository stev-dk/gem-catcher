local GameManager = require "classes.gameManager"
local Paddle = require "classes.paddle"
local CollisionManager  = require "classes.collision"

function love.load()
    GameManager:load()
    CollisionManager:resetCollisions()
    Paddle:load()
    GameManager:setCollisionVars(Paddle)
end

function love.update(dt)
    GameManager:updateCollectibles(dt)
    GameManager:spawnGems(dt)
    Paddle:movement(dt)
    Paddle:update()
end

function love.draw()
    GameManager:drawBackground()
    GameManager:drawCollectibles()
    GameManager:drawUI()
    Paddle:draw()
end
