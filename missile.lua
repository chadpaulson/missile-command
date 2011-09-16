missile = class('missile')

function missile:initialize(world,x,y)
    
    self.xorigin = x
    self.yorigin = y
    
    self.body = love.physics.newBody(world,x,y,0.0001)
    self.body:setBullet(true)
    self.body:setLinearVelocity(self:getInitialLinearVelocity(game.level.missile_speed))
    
    self.shape = love.physics.newRectangleShape(self.body,0,0,8,4)
    self.shape:setData('Missile')
    self.shape:setCategory(1)
    self.shape:setMask(1)
    
    local x1, y1, x2, y2, x3, y3, x4, y4 = self.shape:getBoundingBox()
    self.width = x4 - x1
    self.height = y1 - y2
    
end

function missile:getInitialLinearVelocity(speed)
    
    local rate = (9 - speed) * 2
    local xcoords = {97,105,700,176,247,554,625,696,400,683,550}
    
    vx = xcoords[math.random(1,11)] - self.xorigin
    vy = 500 - self.yorigin
    
    return vx/rate,vy/rate
    
end

function missile:draw(tail_color, color)
    
    love.graphics.setColor(tail_color)
    love.graphics.line(self.xorigin,self.yorigin,self.xorigin + 4,self.yorigin,self.body:getX() - 4,self.body:getY(),self.body:getX(),self.body:getY(),self.xorigin,self.yorigin)
    
    love.graphics.setColor(color)
    love.graphics.polygon('fill',self.shape:getPoints())
    
end