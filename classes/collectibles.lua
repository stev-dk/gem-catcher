local GameManager = require "classes.gameManager"
local Collision = require "classes.collision"

math.randomseed(os.time())
math.random(); math.random(); math.random()

local spriteCache = {}
local soundCache = {}

local Collectible = {}
Collectible.__index = Collectible

function Collectible:new(o)
    o = o or {}
    o.xPos = o.xPos or 100
    o.yPos = o.yPos or -100
    o.width = o.width or 0
    o.height = o.height or 0
    o.points = o.points or 10
    o.canCollide = false
    o.speed = o.speed or 400
    o.sprite = "default.png"
    o.damage = o.damage or 1
    o.image = nil
    o.collectSound = nil
    o.explodeSound = nil
    o.collectibleId = o.collectibleId or "collectible0"
    setmetatable(o, self)
    self.__index = self
    return o
end

function Collectible:load()
    -- Only load the sprite into memory if it dosn't already exists.
    if not spriteCache[self.sprite] then
        spriteCache[self.sprite] = love.graphics.newImage(self.sprite)
    end

    if not soundCache[self.collectSound] then
        soundCache[self.collectSound] = love.audio.newSource(self.collectSound, "static")
    end

    if not soundCache[self.explodeSound] then
        soundCache[self.explodeSound] = love.audio.newSource(self.explodeSound, "static")
    end

    self.image = spriteCache[self.sprite]
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.xPos = math.random(0, GameManager:getScreenWidth() - self.width)
end

function Collectible:update(dt)
    -- MOVEMENT
    self.yPos = self.yPos + (self.speed * dt)

    -- CHECK FOR COLLISION ZONE
    if self.yPos > GameManager.collisionStart - self.height and self.yPos < GameManager.collisionEnd then
        self.canCollide = true
        Collision:addCollectibleCollision(self)
    else
        self.canCollide = false
        Collision:removeCollectibleCollision(self.collectibleId)
    end

    -- CHECK FOR KILLZONE
    if self.yPos > GameManager:getScreenHeight() then
        love.audio.play(soundCache[self.explodeSound])
        GameManager:removeCollectible(self.collectibleId)
        GameManager:loseLife(self.damage)
    end
end

function Collectible:draw()
    love.graphics.draw(self.image, self.xPos, self.yPos, math.deg(0), 1, 1)

    -- DEBUG REMOVE LATER
    local canCollideString = "false"
    if self.canCollide then
        canCollideString = "true"
    end

    love.graphics.print(string.format("Can collide: %s", canCollideString), self.xPos - 25, self.yPos - 30)
    love.graphics.print(string.format("collisionZoneStart: %d", GameManager.collisionStart - self.height), self.xPos - 25, self.yPos - 40)
    love.graphics.print(string.format("collisionZoneEnd: %d", GameManager.collisionEnd), self.xPos - 25, self.yPos - 50)
    -- DEBUG END
end

function Collectible:updateId(newCollectibleId)
    self.collectibleId = newCollectibleId
end

function Collectible:playCollectSound()
    love.audio.play(soundCache[self.collectSound])
end

local RedGem = setmetatable({}, {__index = Collectible})
RedGem.__index = RedGem

function RedGem:new(o)
    o = Collectible.new(self, o)
    o.sprite = 'assets/element_red_diamond.png'
    o.collectSound = 'assets/spell1_0.wav'
    o.explodeSound = 'assets/explode.wav'
    o.points = 25
    o.speed = 100
    return o
end

return {
    RedGem = RedGem
}
