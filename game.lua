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
    self.level = level:new(1)
    self.current_level = 1
    self.score = score:new()
    self.cities = self:buildCities()
    self.audio:play('start_level')
    
end

function game:update(dt)
    
    if self.level.num_missiles == self.level.launched_missiles and table.getn(self.missiles) == 0 and self.level.num_missiles > 0 then
        
        self.score:add(self.level.num_bombs * 5) -- extra bomb bonus
        self:advanceLevel()
        
    end
    
    local shallwebomb = math.random(0,100)
    
    if shallwebomb == 33 and self.audio.start:isStopped() and self.level.num_missiles > self.level.launched_missiles then
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
                self.level.destroyed_missiles = self.level.destroyed_missiles + 1
                self.score:add(25)
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
            self.level.destroyed_missiles = self.level.destroyed_missiles + 1
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
    
    love.graphics.setBackgroundColor(self.level.background_color)
    
    for k,b in pairs(self.bombs) do
        
        b:draw()
                    
    end

    for k,m in pairs(self.missiles) do
        
        m:draw(self.level.missile_tail_color,self.level.missile_color)
                
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
    self.level.launched_missiles = self.level.launched_missiles + 1
    
end

function game:shoot()
        
    local b = bomb:new(world,self.cursor.x,self.cursor.y)    
    
    table.insert(self.bombs,b)
    self.level.num_bombs = self.level.num_bombs - 1
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

function game:advanceLevel()
    
    if self.current_level < 9 then
        
        self.current_level = self.current_level + 1
        self.level = level:new(self.current_level)
        self.audio:play('start_level')
        
    end
    
end

function game:buildCities()
    
    return {}
    
end