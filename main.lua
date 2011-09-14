function love.load()
    --love.mouse.setVisible(false)
    world = love.physics.newWorld(-800,-600,800,600,0,1)
    bombs = {}
    explosions = {}
    cursor = {}
    cursor.x = 350
    cursor.y = 350
    debug = true
end

function love.update(dt)
    
    world:update(dt)
    
    for k,explosion in pairs(explosions) do
        
        if explosion.stage == 40 then
            table.remove(explosions,k)
        elseif explosion.stage < 40 then
            explosion.stage = explosion.stage + 1
        end
        
    end
    
    for k,bomb in pairs(bombs) do
                
        if testCollision(bomb.b,bomb.xtarget,bomb.ytarget) then
            
            bomb.b:destroy()
            bomb.s:destroy()
            table.remove(bombs,k)
            
            local explosion = {}
            explosion.xorigin = bomb.xtarget
            explosion.yorigin = bomb.ytarget
            explosion.stage = 1
            table.insert(explosions,explosion)
            
        end
        
    end
    
    
    if love.keyboard.isDown('up') then
        cursor.y = cursor.y - 4
    end
    
    if love.keyboard.isDown('right') then
        cursor.x = cursor.x + 4
    end
    
    if love.keyboard.isDown('down') then
        cursor.y = cursor.y + 4
    end
    
    if love.keyboard.isDown('left') then
        cursor.x = cursor.x - 4
    end    
    
    
end

function explode(x,y)
    
    local bomb = {}
    bomb.b = love.physics.newBody(world,400,500,1)
    bomb.s = love.physics.newRectangleShape(bomb.b,0,0,8,4)
    bomb.xtarget = x
    bomb.ytarget = y
    
    vx = x - 400
    vy = y - 500
    
    bomb.b:setBullet(true)
    bomb.b:setLinearVelocity(vx,vy)
    
    table.insert(bombs,bomb)
    
end

function love.keypressed(key)
    
    if key == 'escape' then
        love.event.push('q')
    end
        
    if key == ' ' then
        explode(cursor.x,cursor.y)
    end
    
end

function testCollision(body,x,y)

    local vx1 = body:getX() - 400
    local vy1 = body:getY() - 500
    
    local vx2 = x - 400
    local vy2 = y - 500
    
    if vx1 - vx2 < 4 and vy1 - vy2 < 4 then
        return true
    end

    return false

end

function love.draw()
    
    for k,bomb in pairs(bombs) do
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
        --love.graphics.circle('fill',bomb.b:getX(),bomb.b:getY(),bomb.s:getRadius())
        
        x1,y1, x2,y2, x3,y3, x4,y4 = bomb.s:getBoundingBox()
        local w = x4 - x1
        local h = y1 - y2
        


        love.graphics.rectangle('fill',bomb.b:getX(),bomb.b:getY(),w,h)
            
    end
    
    for k,explosion in pairs(explosions) do
        
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
        
        love.graphics.polygon('fill', plotExplosion(explosion.xorigin,explosion.yorigin,explosion.stage))
        
    end
    
    love.graphics.setColor(255,255,255)
    
    love.graphics.rectangle('fill',cursor.x - 18,cursor.y,36,8)    
    
    
    if debug then
        love.graphics.setColor(255,255,255)
        love.graphics.print('(' .. cursor.x .. ',' .. cursor.y .. ')',8,8)
    end
    
end


function plotExplosion(x,y,stage)
    
    if stage < 35 then
        padding = stage * 1.1
    elseif stage >= 35 then
        padding = stage * -0.75
    end
    
    return x,y - padding, x + padding, y, x, y + padding, x - padding, y
    
end
