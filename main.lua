function love.load()
    love.mouse.setVisible(false)
    world = love.physics.newWorld(-800,-600,800,600,0,50)
    bombs = {}
    debug = true
end

function love.update(dt)
    
    world:update(dt)
    
    for k,bomb in pairs(bombs) do
        local rad = bomb.s:getRadius()
        if rad < 35 then
            rad = rad+0.1
            bomb.s:destroy()
            bomb.s = love.physics.newCircleShape(bomb.b,0,0,rad)
        else
            bomb.s:destroy()
            bomb.b:destroy()
            table.remove(bombs,k)
        end
    end
    
end

function explode(x,y)
    
    local bomb = {}
    bomb.b = love.physics.newBody(world,x,y,0)
    bomb.s = love.physics.newCircleShape(bomb.b,0,0,5)
    
    table.insert(bombs,bomb)
    
end

function love.mousereleased(x,y,button)
    
    if button == 'l' and table.getn(bombs) < 3 then
        explode(x,y)
    end
    
end

function love.keyreleased(key)
    if key == 'escape' then
        love.event.push('q')
    end
end

function love.draw()
    
    for k,bomb in pairs(bombs) do
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
        love.graphics.circle('fill',bomb.b:getX(),bomb.b:getY(),bomb.s:getRadius())
    end
    
    if debug then
        love.graphics.setColor(255,255,255)
        love.graphics.print('(' .. love.mouse.getX() .. ',' .. love.mouse.getY() .. ')',8,8)
    end
    
end
