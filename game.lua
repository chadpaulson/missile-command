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
    
end

function game:update()
    
    
    
end