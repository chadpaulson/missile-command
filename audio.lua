audio = class('audio')

function audio:initialize()
    
    self.boom = love.audio.newSource('audio/missile_explode.ogg','static')
    self.launch = love.audio.newSource('audio/launch_bomb.ogg','static')
    self.start = love.audio.newSource('audio/start_level.ogg','static')
    self.over = love.audio.newSource('audio/game_over.ogg','static')
    self.noammo = love.audio.newSource('audio/no_ammo.ogg','static')
    
end

function audio:play(sound)
    
    if sound == 'boom' then
        
        self.boom:rewind()
        self.boom:play()
        
    elseif sound == 'launch' then
        
        if self.boom:isStopped() then
            
            self.launch:rewind()
            self.launch:play()
            
        end
        
    elseif sound == 'start_level' then
        
        self.start:rewind()
        self.start:play()
        
    elseif sound == 'game_over' then
        
        self.over:rewind()
        self.over:play()
        
    elseif sound == 'no_ammo' then
        
        if self.boom:isStopped() then
        
            self.noammo:rewind()
            self.noammo:play()
            
        end
        
    end

end