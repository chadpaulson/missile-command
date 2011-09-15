level = class('level')

function level:initialize(level_num)
    
    self.missile_tail_color = {}
    self.num_missiles = 0
    self.destroyed_missiles = 0
    
    self:loadLevel(level_num)
    
end

function level:loadLevel(level_num)
    
    self.destroyed_missiles = 0
    
    if level_num == 1 then
        self.missile_tail_color = {255,0,0}
        self.num_missiles = 4
    elseif level_num == 2 then
        self.missile_tail_color = {0,255,0}
        self.num_missiles = 6
    elseif level_num == 3 then
        self.missile_tail_color = {34,34,34}
        self.num_missiles = 8
    elseif level_num == 4 then
        self.missile_tail_color = {0,0,255}
        self.num_missiles = 10
    elseif level_num == 5 then
        self.missile_tail_color = {0,24,255}
        self.num_missiles = 12
    elseif level_num == 6 then
        self.missile_tail_color = {0,34,52}
        self.num_missiles = 14
    elseif level_num == 7 then
        self.missile_tail_color = {0,32,53}
        self.num_missiles = 16
    elseif level_num == 8 then
        self.missile_tail_color = {0,3,23}
        self.num_missiles = 18
    elseif level_num == 9 then
        self.missile_tail_color = {0,3,3}
        self.num_missiles = 20
    end
    
end