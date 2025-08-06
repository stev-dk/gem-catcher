GameManager = {}

GameManager.collectibles = {}
GameManager.lives = 3

function GameManager:loseLife(amount)
    self.lives = self.lives - amount
end

function GameManager:draw()
    love.graphics.print("Lives: "..self.lives)
end

return GameManager
