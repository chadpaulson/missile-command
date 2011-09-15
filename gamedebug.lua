gamedebug = class('gamedebug')

function gamedebug:initialize(isEnabled)
    
    self.isEnabled = isEnabled
    
end

function gamedebug:draw()
    
    if self.isEnabled then
        
        love.graphics.setColor(255,255,255)
        love.graphics.print(game.cursor.x .. ' · ' .. game.cursor.y,8,8)
        love.graphics.print(love.timer.getFPS() .. ' fps',8,20)
        love.graphics.print('score: ' .. game.score.total,8,36)
        love.graphics.print('bombs: ' .. game.level.num_bombs,8,48)
        
    end
    
end