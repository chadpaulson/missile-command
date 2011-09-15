city = class('city')

function city:initialize(x,y)
    
    self.x = x
    self.y = y
    self.width = 35
    self.height = 25
    
    self.body = love.physics.newBody(world,x,y,0)
    
    self.shape = love.physics.newRectangleShape(self.body,0,0,self.width,self.height)
    self.shape:setData('city')
    self.shape:setCategory(1)
    self.shape:setMask(1)
    
end

function city:draw(color)
    
    love.graphics.setColor(color)
    love.graphics.polygon('fill',self.shape:getPoints())
    
end