local Collision = {
    collectibles = {}
}

function Collision:addCollectibleCollision(collectible)
    self.collectibles[collectible.collectibleId] = collectible
end

function Collision:removeCollectibleCollision(collectibleId)
    self.collectibles[collectibleId] = nil
end

-- BUGGED
function Collision:resetCollisions()
    for _,collectible in pairs(self.collectibles) do
        self:removeCollectibleCollision(collectible.collectibleId)
    end
end

return Collision
