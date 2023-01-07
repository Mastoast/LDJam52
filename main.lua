function _init()
    gtime = 0
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0}
    printable = 0
    --
    init_level(level_1)
end

-- TODO
-- visuals + feedback
    -- background
    -- tree on apple
    -- clouds
    -- animate for leak/melon
    -- play rythme on screen ????

--Ui
 -- menu
 -- level selection
 -- scoring
 -- level begining / end

-- SFX
-- jump 02 8-8
-- catch 02 0-8

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
    draw_level()
end

function draw_level()
    cls(12)
    
    -- camera
    if shake > 0 then
        camera(cam.x - 2 + rnd(5), cam.y - 2 + rnd(5))
    else
        camera(cam.x, cam.y)
    end

    -- draw map
    map(0, 0, flr(cam.x/8)*8 , 0, 32, 16, 1)

    -- draw objects
    for o in all(objects) do
        o:draw()
    end

    for a in all(particles) do
        a:draw()
    end

    printable = current_runner.collected_counter
    printable = #objects
    -- UI
    print_centered("❎ =>  ", 1, 21, 0)
    print_centered("❎ =>  ", 0, 20, 7)
    spr(melon.spr, cam.x + 76, cam.y + 18)
    print_centered("⬇️ =>  ", 1, 31, 0)
    print_centered("⬇️ =>  ", 0, 30, 7)
    spr(leak.spr, cam.x + 76, cam.y + 28)
    print_centered("🅾️ =>  ", 1, 41, 0)
    print_centered("🅾️ =>  ", 0, 40, 7)
    spr(apple.spr, cam.x + 76, cam.y + 39)

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