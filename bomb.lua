bomb = class('bomb')

function bomb:initialize(world,x,y)
    
    self.xtarget = x
    self.ytarget = y
    
    self.body = love.physics.newBody(world,400,500,1)
    local vx = x - bombtower.x
    local vy = y - bombtower.y
    self.body:setBullet(true)
    self.body:setLinearVelocity(vx,vy)    
    
    self.shape = love.physics.newRectangleShape(self.body,0,0,8,4)
    local x1, y1, x2, y2, x3, y3, x4, y4 = self.shape:getBoundingBox()
    self.width = x4 - x1
    self.height = y1 - y2    
    self.shape:setData('Bomb')
    self.shape:setCategory(1)
    self.shape:setMask(1)
    
end

function bomb:draw()
    
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.rectangle('fill',self.body:getX(),self.body:getY(),self.width,self.height)    
    
end