function love.load()
    --love.mouse.setVisible(false)
    screen = {}
    screen.width = 800
    screen.height = 600
    world = love.physics.newWorld(-800,-600,800,600,0,1.1)
    sounds = {}
    sounds.boom = love.audio.newSource('audio/missile_explode.ogg','static')
    sounds.launch = love.audio.newSource('audio/launch_bomb.ogg','static')
    missiles = {}
    bombs = {}
    explosions = {}
    cursor = {}
    cursor.x = 350
    cursor.y = 350
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
            if explosion.s:testPoint(missile.b:getX(),missile.b:getY()) then
                missile.b:destroy()
                missile.s:destroy()
                sounds.boom:rewind()
                sounds.boom:play()
                table.remove(missiles,k)
            end
        end
        
        if explosion.stage == 75 then
            explosion.b:destroy()
            explosion.s:destroy()
            table.remove(explosions,k)
        elseif explosion.stage < 75 then
            explosion.stage = explosion.stage + 1
            explosion.s:destroy()
            explosion.s = love.physics.newPolygonShape(explosion.b, plotExplosion(explosion.stage))
        end
        
    end
    
    for k,missile in pairs(missiles) do
        
        if missile.b:getY() > 600 then
            missile.b:destroy()
            missile.s:destroy()
            table.remove(missiles,k)
        end
        
    end
    
    for k,bomb in pairs(bombs) do
                
        if testCollision(bomb.b,bomb.xtarget,bomb.ytarget) then
                    
            local explosion = {}
            explosion.xorigin = bomb.xtarget
            explosion.yorigin = bomb.ytarget
            explosion.stage = 1
            explosion.b = love.physics.newBody(world,explosion.xorigin,explosion.yorigin,0)
            explosion.s = love.physics.newPolygonShape(explosion.b, plotExplosion(explosion.stage))
            explosion.s:setCategory(1)
            explosion.s:setMask(1)
            explosion.s:setData('Explosion')
            table.insert(explosions,explosion)
            
            bomb.b:destroy()
            bomb.s:destroy()
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
    
    local missile = {}
    local xcoords = {2,200,350,425,600,725,800}
    local index = math.random(1,7)
    local xcoord = xcoords[index]
    local ycoord = 15
    missile.b = love.physics.newBody(world,xcoord,ycoord,1)
    missile.s = love.physics.newRectangleShape(missile.b,0,0,8,4)
    missile.s:setData('Missile')
    missile.s:setCategory(1)
    missile.s:setMask(1)
    missile.xorigin = xcoord
    missile.yorigin = ycoord
        
    missile.b:setBullet(true)
    missile.b:setLinearVelocity(3,15)
    missile.s:setFriction(1)
    
    table.insert(missiles,missile)
    
end

function explode(x,y)
    
    if sounds.boom:isStopped() then
        sounds.launch:rewind()
        sounds.launch:play()
    end
    local bomb = {}
    bomb.b = love.physics.newBody(world,400,500,1)
    bomb.s = love.physics.newRectangleShape(bomb.b,0,0,8,4)
    bomb.s:setData('Bomb')
    bomb.s:setCategory(1)
    bomb.s:setMask(1)
    bomb.xtarget = x
    bomb.ytarget = y
    
    local vx = x - bombtower.x
    local vy = y - bombtower.y
    
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
    
    for k,bomb in pairs(bombs) do
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
        
        x1, y1, x2, y2, x3, y3, x4, y4 = bomb.s:getBoundingBox()
        local w = x4 - x1
        local h = y1 - y2
        


        love.graphics.rectangle('fill',bomb.b:getX(),bomb.b:getY(),w,h)
            
    end

    for k,missile in pairs(missiles) do
        
        love.graphics.setColor(255,0,0)
        love.graphics.line(missile.xorigin,missile.yorigin,missile.xorigin + 8,missile.yorigin,missile.b:getX() + 8,missile.b:getY(),missile.b:getX(),missile.b:getY(),missile.xorigin,missile.yorigin)
        
        love.graphics.setColor(255,255,255)
        mx1, my1, mx2, my2, mx3, my3, mx4, my4 = missile.s:getBoundingBox()
        local w = mx4 - mx1
        local h = my1 - my2
        love.graphics.rectangle('fill',missile.b:getX(),missile.b:getY(),w,h)
        
    end
    
    for k,explosion in pairs(explosions) do
        
        love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
        
        love.graphics.polygon('fill', explosion.s:getPoints())
        
    end
    

    
    love.graphics.setColor(255,255,255)
    
    love.graphics.rectangle('fill',cursor.x - 18,cursor.y,36,8)    
    
    
    if debug then
        love.graphics.setColor(255,255,255)
        love.graphics.print('(' .. cursor.x .. ',' .. cursor.y .. ')',8,8)
    end
    
end


function plotExplosion(stage)
    
    x = 0
    y = 0
    if stage < 15 then
        padding = stage * 2
    elseif stage > 15 and stage < 50 then
        padding = 45
    elseif stage >= 50 then
        padding = 80 - stage
    end
    
    return x,y - padding, x + padding, y, x, y + padding, x - padding, y
    
end
