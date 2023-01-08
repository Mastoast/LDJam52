function _init()
    gtime = 0
    gstate = 0 -- 0-menu | 1-level | 2-level end
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0}
    printable = 0
    debug_pattern_offset = 0
    level_list = {level_0, level_1, level_2}
    --
    init_menu()
    -- init_level(level_2)
end

function init_menu()
    gtime = 0
    gstate = 0
    tutorial_shown = false
    selected_level = 0
    cam.x = 0
    cam.y = 0
    objects = {}
    particles = {}
end

-- TODO
-- visuals + feedback
    -- clouds
    -- more backgrounds in rythm ?? (sspr)

-- Levels
    -- 3

function _update60()
    -- timers
    gtime += 1

    if gstate == 0 then update_menu()
    else update_level() end
end

function _draw()
    if gstate == 0 then draw_menu()
    else draw_level() end

    print(printable, cam.x + 80, cam.y + 120, 0)
end

-- MENU
function update_menu()
    if not tutorial_shown then
        if btnp(⬇️) then
            sfx(2, 0, 8, 4)
            if (selected_level+1 == #level_list) then
                tutorial_shown = true
                selected_level = 0
            else
                selected_level = (selected_level + 1)%#level_list
            end
        end
        if btnp(⬆️) then
            sfx(2, 0, 8, 4)
            selected_level = (selected_level - 1)%#level_list
        end
        if (btnp(4) or btnp(5)) then
            sfx(1, 2, 0, 8)
            init_level(level_list[selected_level+1])
        end
    else
        if btnp(❎) or btnp(🅾️) then
            sfx(2, 0, 8, 4)
            tutorial_shown = false
        end
    end
end

function draw_menu()
    cls(1)
    camera(cam.x, cam.y)
    
    -- background
    line(cam.x - 40, 128, cam.x + 4, 35, 5)
    line(cam.x + 4, 35, cam.x + 68, 128, 5)
    line(cam.x + 30, 74, cam.x + 55, 55, 5)
    line(cam.x + 55, 55, cam.x + 88, 135, 5)
    line(cam.x + 13, 128, cam.x + 150, 65, 5)
    line(cam.x + 150, 65, cam.x + 210, 128, 5)

    map(0, 47, 0, 0, 16, 16, 0)
    spr(apple.spr, 78, 83)
    circfill(cam.x + 95, cam.y + 25, 12, 7)

    if tutorial_shown then
        print_centered("Use the correct button", 1, 4, 0)
        print_centered("Use the correct button", 0, 3, 3)
        print_centered("in rythm to harvest", 1, 12, 0)
        print_centered("in rythm to harvest", 0, 11, 3)
        print_centered("the corresponding item", 1, 20, 0)
        print_centered("the corresponding item", 0, 19, 3)

        print("⬆️ => ", 11, 41, 0)
        print("⬆️ => ", 10, 40, (btn(⬆️) and 8) or 7)
        spr(apple.spr, 35, 39)
        print("⬅️ => ", 11, 51, 0)
        print("⬅️ => ", 10, 50, (btn(⬅️) and 8) or 7)
        spr(melon.spr, 35, 49)
        print("➡️ => ", 11, 61, 0)
        print("➡️ => ", 10, 60, (btn(➡️) and 8) or 7)
        spr(leak.spr, 35, 59)

        print("<= TRY IT !", 60, 51, 0)
        print("<= TRY IT !", 60, 50, 8)

        print_centered("❎ or 🅾️ back to menu", 1, 116, 0)
        print_centered("❎ or 🅾️ back to menu", 0, 115, 7)
    else
        print_centered("You're under harvest", 1, 11, 0)
        print_centered("You're under harvest", 1, 10, 0)
        print_centered("You're under harvest", 0, 10, 3)

        -- level selection
        local incr = 0
        for lvl in all(level_list) do
            local lvl_label = (level_list[selected_level+1] == lvl and "♪ "..lvl.name.." ♪")
            or lvl.name
            print_centered(lvl_label, 1, 41 + 8*incr, 0)
            print_centered(lvl_label, 0, 40 + 8*incr, 7)
            if lvl.best_score>0 and lvl.max_score>0 then
                print(flr((lvl.best_score/lvl.max_score)*100).."%", 101, 41 + 8*incr, 8)
                print(flr((lvl.best_score/lvl.max_score)*100).."%", 100, 40 + 8*incr, 7)
            end
            incr += 1
        end

        print_centered("⬇️ how to play ⬇️", 1, 71, 0)
        print_centered("⬇️ how to play ⬇️", 0, 70, 7)

        if gtime %128 > 32 then 
            print_centered(" press 🅾️ or ❎ to start ", 1, 115, 1)
            print_centered(" press 🅾️ or ❎ to start ", 0, 116, 7)
        end
    end
end

-- LEVELS
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

    --end of music
    if stat(54) == -1 and gstate != 2 then
        sfx(1, 0, 8, 8)
        gstate = 2
        local max_score_counter = 0
        for o in all(objects) do
            if o.base == leak or o.base == melon or o.base == apple then
                max_score_counter += 300
            end
        end
        current_level.max_score = max_score_counter
        current_level.best_score = score_count
    end

    if gstate == 2 then

        if btnp(⬅️) then
            sfx(1, 0, 16, 4)
            init_menu()
        end
    end
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
    local bck_speed = 55
    local offset_x = (gtime/bck_speed) - 50
    line(cam.x - 40 - offset_x, 128, cam.x + 4 - offset_x, 35, 5)
    line(cam.x + 4 - offset_x, 35, cam.x + 68 - offset_x, 128, 5)
    line(cam.x + 30 - offset_x, 74, cam.x + 55 - offset_x, 55, 5)
    line(cam.x + 55 - offset_x, 55, cam.x + 88 - offset_x, 135, 5)
    --
    bck_speed = 4
    offset_x = (gtime/bck_speed)%256
    line(cam.x + 130 - offset_x, 128, cam.x + 150 - offset_x, 65, 5)
    line(cam.x + 150 - offset_x, 65, cam.x + 210 - offset_x, 128, 5)

    -- draw map
    map(0, 0, flr(cam.x/8)*8 , 0, 32, 16, 1)

    -- draw objects
    for o in all(objects) do
        o:draw()
    end

    for a in all(particles) do
        a:draw()
    end

    -- UI
    local last_color=peek(0x5f25)
    print("SCORE : "..score_count, cam.x + 4, cam.y + 4, 0)
    print("SCORE : "..score_count, cam.x + 3, cam.y + 3, last_color)
    print("COMBO X"..combo_count, cam.x + 4, cam.y + 12, 0)
    print("COMBO X"..combo_count, cam.x + 3, cam.y + 11, 7)

    -- End of level
    if gstate == 2 then
        print_centered("Level cleared : "..flr((score_count/current_level.max_score)*100).."%",1, cam.y + 63, 8)
        print_centered("Level cleared : "..flr((score_count/current_level.max_score)*100).."%", 0, cam.y + 62, 7)
        print_centered("best combo : "..best_combo, 1, cam.y + 71, 8)
        print_centered("best combo : "..best_combo, 0, cam.y + 70, 7)
        --
        print_centered("⬅️ back to menu", 1, 116, 0)
        print_centered("⬅️ back to menu", 0, 115, 7)
    end
end

-- UTILS
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