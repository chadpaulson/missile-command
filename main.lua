require 'middleclass'
require 'game'
require 'level'
require 'gamedebug'
require 'audio'
require 'missile'
require 'explosion'
require 'bomb'
require 'cursor'

function love.load()
    
    world = love.physics.newWorld(-800,-600,800,600,0,1.1)

    game = game:new()
    
    debug = gamedebug:new(true) -- set to false to disable debug display
    love.mouse.setVisible(false)
    
end

function love.update(dt)
    
    world:update(dt)
    
    local shallwebomb = math.random(0,150)
    
    if shallwebomb == 33 then
        bringemon()
        bringemon()
        bringemon()
    end
    
    for k,explosion in pairs(game.explosions) do

        -- check for exploded missiles
        for k,missile in pairs(game.missiles) do
            if explosion.shape:testPoint(missile.body:getX(),missile.body:getY()) then
                missile.body:destroy()
                missile.shape:destroy()
                game.audio:play('boom')
                table.remove(game.missiles,k)
            end
        end
                
        if not explosion:update() then
            table.remove(game.explosions,k)
        end
        
    end
    
    for k,missile in pairs(game.missiles) do
        
        if missile.body:getY() > 600 then
            missile.body:destroy()
            missile.shape:destroy()
            table.remove(game.missiles,k)
        end
        
    end
    
    for k,b in pairs(game.bombs) do
                
        if testCollision(b.body,b.xtarget,b.ytarget) then
                                
            local e = explosion:new(world,b.xtarget,b.ytarget)
            table.insert(game.explosions,e)
            
            b.body:destroy()
            b.shape:destroy()
            table.remove(game.bombs,k)
                        
        end
        
    end
    
    if love.keyboard.isDown('up') and game.cursor.y > 0 then
        game.cursor.y = game.cursor.y - 8
    elseif game.cursor.y < 0 then
        game.cursor.y = 0
    end
    
    if love.keyboard.isDown('right') and game.cursor.x < game.screen.width then
        game.cursor.x = game.cursor.x + 8
    elseif game.cursor.x > game.screen.width then
        game.cursor.x = game.screen.width
    end
    
    if love.keyboard.isDown('down') and game.cursor.y < game.bombtower.y then
        game.cursor.y = game.cursor.y + 8
    elseif game.cursor.y > game.bombtower.y then
        game.cursor.y = game.bombtower.y
    end
    
    if love.keyboard.isDown('left') and game.cursor.x > 0 then
        game.cursor.x = game.cursor.x - 8
    elseif game.cursor.x < 0 then
        game.cursor.x = 0
    end
    
end

function bringemon()
    
    local xcoords = {2,200,350,425,600,725,800}
    local index = math.random(1,7)
    local xcoord = xcoords[index]
    local ycoord = 15
    local m = missile:new(world,xcoord,ycoord)
        
    table.insert(game.missiles,m)
    
end

function shoot(x,y)
        
    local b = bomb:new(world,x,y)    
    table.insert(game.bombs,b)
    game.audio:play('launch')
    
end

function love.keypressed(key)
    
    if key == 'escape' then
        love.event.push('q')
    end
        
    if key == ' ' then
        shoot(game.cursor.x,game.cursor.y)
    end
    
end

function testCollision(body,x,y)

    local vx1 = body:getX() - game.bombtower.x
    local vy1 = body:getY() - game.bombtower.y
    
    local vx2 = x - game.bombtower.x
    local vy2 = y - game.bombtower.y
    
    if vx1 - vx2 < 4 and vy1 - vy2 < 4 then
        return true
    end

    return false

end

function love.draw()
    
    for k,b in pairs(game.bombs) do
        
        b:draw()
                    
    end

    for k,m in pairs(game.missiles) do
        
        m:draw()
                
    end
    
    for k,e in pairs(game.explosions) do
        
        e:draw()
        
    end
    
    game.cursor:draw()
    
    debug:draw()
    
end
