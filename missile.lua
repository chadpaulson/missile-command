missile = class('missile')

function missile:initialize(world,x,y)
    
    self.xorigin = x
    self.yorigin = y
    
    self.body = love.physics.newBody(world,x,y,1)
    self.body:setBullet(true)
    self.body:setLinearVelocity(self:getInitialLinearVelocity())
    
    self.shape = love.physics.newRectangleShape(self.body,0,0,8,4)
    self.shape:setData('Missile')
    self.shape:setCategory(1)
    self.shape:setMask(1)
    
    local x1, y1, x2, y2, x3, y3, x4, y4 = self.shape:getBoundingBox()
    self.width = x4 - x1
    self.height = y1 - y2
    
end

function missile:getInitialLinearVelocity()
    
    return 3,15
    
end

function missile:draw()
    
    love.graphics.setColor(255,0,0)
    love.graphics.line(self.xorigin,self.yorigin,self.xorigin + 8,self.yorigin,self.body:getX() + 8,self.body:getY(),self.body:getX(),self.body:getY(),self.xorigin,self.yorigin)
    
    love.graphics.setColor(255,255,255)

    love.graphics.rectangle('fill',self.body:getX(),self.body:getY(),self.width,self.height)
    
end