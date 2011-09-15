game = class('game')

function game:initialize()
    
    self.screen = {}
    self.screen.width = 800
    self.screen.height = 600
    self.audio = audio:new()
    self.missiles = {}
    self.bombs = {}
    self.explosions = {}
    self.cursor = cursor:new(350,350)
    self.bombtower = {}
    self.bombtower.x = 400
    self.bombtower.y = 500
    
    self.audio:play('start_level')
    
end

function game:update(dt)
    
    local shallwebomb = math.random(0,150)
    
    if shallwebomb == 33 and self.audio.start:isStopped() then
        self:launchMissile()
        self:launchMissile()
        self:launchMissile()
    end
    
    for k,explosion in pairs(self.explosions) do

        -- check for exploded missiles
        for k,missile in pairs(self.missiles) do
            if explosion.shape:testPoint(missile.body:getX(),missile.body:getY()) then
                missile.body:destroy()
                missile.shape:destroy()
                self.audio:play('boom')
                table.remove(self.missiles,k)
            end
        end
                
        if not explosion:update() then
            table.remove(self.explosions,k)
        end
        
    end
    
    for k,missile in pairs(self.missiles) do
        
        if missile.body:getY() > 600 then
            missile.body:destroy()
            missile.shape:destroy()
            table.remove(self.missiles,k)
        end
        
    end
    
    for k,b in pairs(self.bombs) do
                
        if self:testCollision(b.body,b.xtarget,b.ytarget) then
                                
            local e = explosion:new(world,b.xtarget,b.ytarget)
            table.insert(self.explosions,e)
            
            b.body:destroy()
            b.shape:destroy()
            table.remove(self.bombs,k)
                        
        end
        
    end
    
    if love.keyboard.isDown('up') and self.cursor.y > 0 then
        self.cursor.y = self.cursor.y - 8
    elseif self.cursor.y < 0 then
        self.cursor.y = 0
    end
    
    if love.keyboard.isDown('right') and self.cursor.x < self.screen.width then
        self.cursor.x = self.cursor.x + 8
    elseif self.cursor.x > self.screen.width then
        self.cursor.x = self.screen.width
    end
    
    if love.keyboard.isDown('down') and self.cursor.y < self.bombtower.y then
        self.cursor.y = self.cursor.y + 8
    elseif self.cursor.y > self.bombtower.y then
        self.cursor.y = self.bombtower.y
    end
    
    if love.keyboard.isDown('left') and self.cursor.x > 0 then
        self.cursor.x = self.cursor.x - 8
    elseif self.cursor.x < 0 then
        self.cursor.x = 0
    end    
    
end

function game:draw()
    
    for k,b in pairs(self.bombs) do
        
        b:draw()
                    
    end

    for k,m in pairs(self.missiles) do
        
        m:draw()
                
    end
    
    for k,e in pairs(self.explosions) do
        
        e:draw()
        
    end
    
    self.cursor:draw()
    
end

function game:launchMissile()
    
    local xcoords = {2,200,350,425,600,725,800}
    local index = math.random(1,7)
    local xcoord = xcoords[index]
    local ycoord = 15
    local m = missile:new(world,xcoord,ycoord)
        
    table.insert(self.missiles,m)    
    
end

function game:shoot()
        
    local b = bomb:new(world,self.cursor.x,self.cursor.y)    
    
    table.insert(self.bombs,b)
    self.audio:play('launch')
    
end

function game:testCollision(body,x,y)

    local vx1 = body:getX() - game.bombtower.x
    local vy1 = body:getY() - game.bombtower.y
    
    local vx2 = x - game.bombtower.x
    local vy2 = y - game.bombtower.y
    
    if vx1 - vx2 < 4 and vy1 - vy2 < 4 then
        return true
    end

    return false

end