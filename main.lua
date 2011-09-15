require 'middleclass'
require 'audio'
require 'missile'
require 'explosion'
require 'bomb'
require 'cursor'

function love.load()
    love.mouse.setVisible(false)
    screen = {}
    screen.width = 800
    screen.height = 600
    world = love.physics.newWorld(-800,-600,800,600,0,1.1)
    audio = audio:new()
    missiles = {}
    bombs = {}
    explosions = {}
    cursor = cursor:new(350,350)
    bombtower = {}
    bombtower.x = 400
    bombtower.y = 500
    debug = true
end

function love.update(dt)
    
    world:update(dt)
    
    local shallwebomb = math.random(0,150)
    
    if shallwebomb == 33 then
        bringemon()
        bringemon()
        bringemon()
    end
    
    for k,explosion in pairs(explosions) do

        -- check for exploded missiles
        for k,missile in pairs(missiles) do
            if explosion.shape:testPoint(missile.body:getX(),missile.body:getY()) then
                missile.body:destroy()
                missile.shape:destroy()
                audio:play('boom')
                table.remove(missiles,k)
            end
        end
                
        if not explosion:update() then
            table.remove(explosions,k)
        end
        
    end
    
    for k,missile in pairs(missiles) do
        
        if missile.body:getY() > 600 then
            missile.body:destroy()
            missile.shape:destroy()
            table.remove(missiles,k)
        end
        
    end
    
    for k,b in pairs(bombs) do
                
        if testCollision(b.body,b.xtarget,b.ytarget) then
                                
            local e = explosion:new(world,b.xtarget,b.ytarget)
            table.insert(explosions,e)
            
            b.body:destroy()
            b.shape:destroy()
            table.remove(bombs,k)
                        
        end
        
    end
    
    if love.keyboard.isDown('up') and cursor.y > 0 then
        cursor.y = cursor.y - 8
    elseif cursor.y < 0 then
        cursor.y = 0
    end
    
    if love.keyboard.isDown('right') and cursor.x < screen.width then
        cursor.x = cursor.x + 8
    elseif cursor.x > screen.width then
        cursor.x = screen.width
    end
    
    if love.keyboard.isDown('down') and cursor.y < bombtower.y then
        cursor.y = cursor.y + 8
    elseif cursor.y > bombtower.y then
        cursor.y = bombtower.y
    end
    
    if love.keyboard.isDown('left') and cursor.x > 0 then
        cursor.x = cursor.x - 8
    elseif cursor.x < 0 then
        cursor.x = 0
    end
    
end

function bringemon()
    
    local xcoords = {2,200,350,425,600,725,800}
    local index = math.random(1,7)
    local xcoord = xcoords[index]
    local ycoord = 15
    local m = missile:new(world,xcoord,ycoord)
        
    table.insert(missiles,m)
    
end

function shoot(x,y)
        
    local b = bomb:new(world,x,y)    
    table.insert(bombs,b)
    audio:play('launch')
    
end

function love.keypressed(key)
    
    if key == 'escape' then
        love.event.push('q')
    end
        
    if key == ' ' then
        shoot(cursor.x,cursor.y)
    end
    
end

function testCollision(body,x,y)

    local vx1 = body:getX() - bombtower.x
    local vy1 = body:getY() - bombtower.y
    
    local vx2 = x - bombtower.x
    local vy2 = y - bombtower.y
    
    if vx1 - vx2 < 4 and vy1 - vy2 < 4 then
        return true
    end

    return false

end

function love.draw()
    
    for k,b in pairs(bombs) do
        
        b:draw()
                    
    end

    for k,m in pairs(missiles) do
        
        m:draw()
                
    end
    
    for k,e in pairs(explosions) do
        
        e:draw()
        
    end
    
    cursor:draw()
    
    if debug then
        
        love.graphics.setColor(255,255,255)
        love.graphics.print('(' .. cursor.x .. ',' .. cursor.y .. ')',8,8)
        love.graphics.print(' ' .. love.timer.getFPS() .. ' FPS',8,20)
        
    end
    
end
