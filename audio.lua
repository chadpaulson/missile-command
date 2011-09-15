audio = class('audio')

function audio:initialize()
    
    self.boom = love.audio.newSource('audio/missile_explode.ogg','static')
    self.launch = love.audio.newSource('audio/launch_bomb.ogg','static')
    self.start = love.audio.newSource('audio/start_level.ogg')
    
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
        
    end
    
end