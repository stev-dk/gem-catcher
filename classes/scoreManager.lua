local scoreManager = {}
scoreManager.__index = scoreManager

function scoreManager:new(o)
    o = o or {}
    o.score = 0
    setmetatable(o, self)
    self.__index = self
    return o
end

function scoreManager:addScore(amount)
    self.score = self.score + amount
end

function scoreManager:draw()
    love.graphics.print(self.score)
end

return scoreManager
