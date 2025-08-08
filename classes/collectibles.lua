math.randomseed(os.time())
math.random(); math.random(); math.random()

-- rename locals to lowercase?
local Screen = {
    minWidth = 0,
    maxHeight = 200
}
local spriteCache = {}

local Collectible = {}
Collectible.__index = Collectible

function Collectible:new(o)
    o = o or {}
    o.xPos = o.xPos or 100
    o.yPos = o.yPos or -100
    o.width = o.width or 0
    o.points = o.points or 10
    o.speed = o.speed or 400
    o.sprite = "default.png"
    o.damage = o.damage or 1
    o.image = nil
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

    self.image = spriteCache[self.sprite]
    self.width = self.image:getWidth()
    self.xPos = math.random(Screen.minWidth, GameManager:getScreenWidth() - self.width)
end

function Collectible:update(dt)
    self.yPos = self.yPos + (self.speed * dt)

    -- Refactor maxHeight name... killzone? or similar
    if self.yPos > GameManager:getScreenHeight() then
        GameManager:removeCollectible(self.collectibleId)
        GameManager:loseLife(self.damage)
    end
end

function Collectible:draw()
    love.graphics.draw(self.image, self.xPos, self.yPos, math.deg(0), 1, 1)
end

function Collectible:updateId(newCollectibleId)
    self.collectibleId = newCollectibleId
end

local RedGem = setmetatable({}, {__index = Collectible})
RedGem.__index = RedGem

function RedGem:new(o)
    o = Collectible.new(self, o)
    o.sprite = 'assets/element_red_diamond.png'
    o.points = 25
    o.speed = 100
    return o
end

return {
    RedGem = RedGem
}
