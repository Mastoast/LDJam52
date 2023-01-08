function _init()
    gtime = 0
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0}
    printable = 0
    debug_pattern_offset = 0
    --
    init_level(level_1)
end

-- TODO
-- visuals + feedback
    -- background
    -- clouds

-- UI
    -- menu
    -- level selection
    -- scoring dynamic !!
    -- level end

-- Levels
    -- 4th channel
    -- 2
    -- 3

function _update60()
    -- timers
    gtime += 1

    update_level()
end

function update_level()
    --
    shake = max(shake - 1)
    --
    cam.x = current_runner.x - 24

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

        for a in all(particles) do
            a:update()
        end
    end
end

function _draw()
    --draw_menu()
    draw_level()
end

function draw_menu()
    cls(1)

    cam.x = 0
    cam.y = 0

    map(0, 47, 0, 0, 16, 16, 0)
end

function draw_level()
    cls(1)
    
    -- camera
    if shake > 0 then
        camera(cam.x - 2 + rnd(5), cam.y - 2 + rnd(5))
    else
        camera(cam.x, cam.y)
    end

    -- draw background
    -- TODO
    local bck_speed = 1
    local offset_x = (gtime/bck_speed)--%128
    line(cam.x - 40 - offset_x, 128, cam.x + 4 - offset_x, 35, 5)
    line(cam.x + 4 - offset_x, 35, cam.x + 68 - offset_x, 128, 5)
    line(cam.x + 30 - offset_x, 74, cam.x + 55 - offset_x, 55, 5)
    line(cam.x + 55 - offset_x, 55, cam.x + 88 - offset_x, 135, 5)
    --
    bck_speed = 1
    offset_x = (gtime/bck_speed)
    line(cam.x + 110 - offset_x, 128, cam.x + 130 - offset_x, 55, 5)
    line(cam.x + 130 - offset_x, 55, cam.x + 190 - offset_x, 128, 5)

    -- draw map
    map(0, 0, flr(cam.x/8)*8 , 0, 32, 16, 1)

    -- draw objects
    for o in all(objects) do
        o:draw()
    end

    for a in all(particles) do
        a:draw()
    end

    -- printable = #objects
    -- UI

    print(printable, cam.x + 80, cam.y + 120, 0)
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