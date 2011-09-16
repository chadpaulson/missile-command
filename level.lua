level = class('level')

function level:initialize(level_num)
    
    self.missile_color = {}
    self.missile_tail_color = {}
    self.background_color = {}
    self.city_color = {}
    self.ground_color = {}
    
    self.num_bombs = 0
    self.num_missiles = 0
    self.destroyed_missiles = 0
    self.launched_missiles = 0
    self.destroyed_cities = 0
    self.missile_speed = 0
    self.missile_interval = 0
    
    self:loadLevel(level_num)
    
end

function level:loadLevel(level_num)
    
    self.destroyed_missiles = 0
    self.launched_missiles = 0
    self.num_bombs = 30
    self.destroyed_cities = 0
    
    if level_num == 1 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {255,0,0}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}
        self.num_missiles = 12
        self.missile_speed = 1
        self.missile_interval = 150
        
    elseif level_num == 2 then
        
        self.missile_color = {125,48,173}
        self.missile_tail_color = {255,255,255}
        self.background_color = {147,0,0}
        self.city_color = {50,132,50}
        self.ground_color = {125,48,173}        
        self.num_missiles = 14
        self.missile_speed = 2
        self.missile_interval = 125
        
    elseif level_num == 3 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {154,252,154}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 16
        self.missile_speed = 3
        self.missile_interval = 100
        
    elseif level_num == 4 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {255,0,0}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 18
        self.missile_speed = 4
        self.missile_interval = 75
        
    elseif level_num == 5 then
        
        self.missile_color = {0,0,0}
        self.missile_tail_color = {255,255,255}
        self.background_color = {50,132,50}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 20
        self.missile_speed = 5
        self.missile_interval = 65
        
    elseif level_num == 6 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,34,52}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 22
        self.missile_speed = 6
        self.missile_interval = 55
        
    elseif level_num == 7 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,32,53}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 24
        self.missile_speed = 7
        self.missile_interval = 45
        
    elseif level_num == 8 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,3,23}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 26
        self.missile_speed = 8
        self.missile_interval = 40
        
    elseif level_num == 9 then
        
        self.missile_color = {255,255,255}
        self.missile_tail_color = {0,3,3}
        self.background_color = {0,0,0}
        self.city_color = {20,104,230}
        self.ground_color = {230,158,20}        
        self.num_missiles = 28
        self.missile_speed = 9
        self.missile_interval = 33
        
    end
    
end