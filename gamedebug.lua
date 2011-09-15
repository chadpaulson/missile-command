gamedebug = class('gamedebug')

function gamedebug:initialize(isEnabled)
    
    self.isEnabled = isEnabled
    
end

function gamedebug:draw()
    
    if self.isEnabled then
        
        love.graphics.setColor(255,255,255)
        love.graphics.print('(' .. game.cursor.x .. ',' .. game.cursor.y .. ')',8,8)
        love.graphics.print(' ' .. love.timer.getFPS() .. ' FPS',8,20)
        love.graphics.print('SCORE: ' .. game.score.total,8,36)
        love.graphics.print('BOMBS: ' .. game.level.num_bombs,8,48)
        
    end
    
end