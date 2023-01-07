function _init()
    gtime = 0
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0}
    printable = 0
    --
    init_level()
end

function init_level()
    objects = {}
    particles = {}
    -- gen checkpoints
    -- for i=0, 127 do
    --     for y=0, 63 do
    --         if mget(i, y) == 4 then
    --             create(checkpoint, i*8 + 4, y*8 + 4)
    --         end
    --     end
    -- end
end

function _update60()
    -- timers
    gtime += 1

    update_level()
end

function update_level()
    --
    shake = max(shake - 1)

    -- freeze
    if freeze_time > 0 then
        freeze_time -= 1
    else
        for o in all(objects) do
            if o.freeze > 0 then
                o.freeze -= 1
            else
                o:update()
            end

            if o.base != player and o.destroyed then
                del(objects, o)
            end
        end
    end
end

function _draw()
    cls(12)
    
    -- camera
    if shake > 0 then
        camera(cam.x - 2 + rnd(5), cam.y - 2 + rnd(5))
    else
        camera(cam.x, cam.y)
    end

    -- draw map
    map(0, 0, 0, 0, 16, 16)

    -- draw objects
    for o in all(objects) do
        o:draw()
    end

    -- UI
    
    --print(printable, cam.x + 80, cam.y + 120, 4)
end


-- linear interpolation
function lerp(start,finish,t)
    return mid(start,start*(1-t)+finish*t,finish)
end

-- print at center
function print_centered(str, offset_x, y, col)
    print(str, cam.x + 64 - (#str * 2) + offset_x, y, col)
end

-- random range
function rrnd(min, max)
    return flr(min + rnd(max - min))
end