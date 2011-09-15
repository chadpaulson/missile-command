level = class('level')

function level:initialize(level_num)
    
    self.missile_color = {}
    self.missile_tail_color = {}
    self.background_color = {}
    
    self.num_missiles = 0
    self.destroyed_missiles = 0
    self.launched_missiles = 0
    
    self:loadLevel(level_num)
    
end

function level:loadLevel(level_num)
    
    self.destroyed_missiles = 0
    self.launched_missiles = 0
    
    if level_num == 1 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {255,0,0}
        self.background_color = {0,0,0}
        self.num_missiles = 4
        
    elseif level_num == 2 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {255,0,0}
        self.background_color = {0,0,0}
        self.num_missiles = 6
        
    elseif level_num == 3 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {154,252,154}
        self.background_color = {0,0,0}
        self.num_missiles = 8
        
    elseif level_num == 4 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {255,0,0}
        self.background_color = {0,0,0}
        self.num_missiles = 10
        
    elseif level_num == 5 then
        
        self.missile_color = {0,0,0}
        self.missile_tail_color = {255,255,255}
        self.background_color = {50,132,50}
        self.num_missiles = 12
        
    elseif level_num == 6 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,34,52}
        self.background_color = {0,0,0}
        self.num_missiles = 14
        
    elseif level_num == 7 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,32,53}
        self.background_color = {0,0,0}
        self.num_missiles = 16
        
    elseif level_num == 8 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,3,23}
        self.background_color = {0,0,0}
        self.num_missiles = 18
        
    elseif level_num == 9 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,3,3}
        self.background_color = {0,0,0}
        self.num_missiles = 20
        
    end
    
end