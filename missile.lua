missile = class('missile')

function missile:initialize(world,x,y)
    
    self.xorigin = x
    self.yorigin = y
    self.width = 10
    self.height = 8
    
    self.body = love.physics.newBody(world,x,y,0.0001)
    self.body:setBullet(true)
    self.body:setLinearVelocity(self:getInitialLinearVelocity(game.level.missile_speed))
    
    self.shape = love.physics.newRectangleShape(self.body,0,0,self.width,self.height)
    self.shape:setData('Missile')
    self.shape:setCategory(1)
    self.shape:setMask(1)
        
end

function missile:getInitialLinearVelocity(speed)
    
    local rate = (9 - speed) * 2
    local xcoords = {85,690,169,240,554,625,696,683,550}
    
    vx = xcoords[math.random(1,9)] - self.xorigin
    vy = 500 - self.yorigin
    
    return vx/rate,vy/rate
    
end

function missile:draw(tail_color, color)
    
    love.graphics.setColor(tail_color)
    love.graphics.line(self.xorigin,self.yorigin,self.xorigin + self.height,self.yorigin,self.body:getX() - 4,self.body:getY(),self.body:getX(),self.body:getY(),self.xorigin,self.yorigin)
    
    love.graphics.setColor(color)
    love.graphics.polygon('fill',self.shape:getPoints())
    
end