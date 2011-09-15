score = class('score')

function score:initialize()
    
    self.total = 0
    
end

function score:add(num)
    
    self.total = self.total + num
    
end

function score:del(num)
    
    self.total = self.total - num
    
end