math.randomseed(os.time())
math.random(); math.random(); math.random()

local Screen = {
    minWidth = 0,
    maxWidth = 800
}

local Collectible = {}
Collectible.__index = Collectible

function Collectible:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.xPos = o.xPos or 100
    o.yPos = o.yPos or -100
    o.points = o.points or 10
    o.speed = o.speed or 25
    o.sprite = "default.png"
    o.image = nil
    return o
end

function Collectible:load()
    self.image = love.graphics.newImage(self.sprite)
    self.xPos = math.random(Screen.minWidth, Screen.maxWidth)
end

function Collectible:update(dt)
    self.yPos = self.yPos + (self.speed * dt)
end

function Collectible:draw()
    love.graphics.draw(self.image, self.xPos, self.yPos, math.deg(0), 1, 1)
end

local RedGem = setmetatable({}, {__index = Collectible})
RedGem.__index = RedGem

function RedGem:new(o)
    o = Collectible.new(self, o)
    o.sprite = 'assets/element_red_diamond.png'
    o.points = 25
    o.speed = 50
    return o
end

return {
    RedGem = RedGem
}
