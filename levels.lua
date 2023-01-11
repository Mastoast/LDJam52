level_0 = {}
level_0.name = "Tutorial"
level_0.start_music = 0
level_0.ch_mask = 7
level_0.speed = 16
level_0.events = {{x = 0, y = 18}, {x = 0, y = 19}}
level_0.event_offset = 64
-- player best
level_0.best_score = -1
-- maximum possible score on level
level_0.max_score = -1
level_0.saved_score = -1

level_1 = {}
level_1.name = "Level 1"
level_1.start_music = 10
level_1.ch_mask = 7
level_1.speed = 16
level_1.events = {{x = 0, y = 22}, {x = 0, y = 23}}
level_1.event_offset = 64
level_1.best_score = -1
level_1.max_score = -1
level_1.saved_score = -1

level_2 = {}
level_2.name = "Level 2"
level_2.start_music = 18
level_2.ch_mask = 7
level_2.speed = 16
level_2.events = {{x = 0, y = 27}, {x = 0, y = 28}, {x = 0, y = 29}}
level_2.event_offset = 64
level_2.best_score = -1
level_2.max_score = -1
level_2.saved_score = -1

level_3 = {}
level_3.name = "Level 3"
level_3.start_music = 18
level_3.ch_mask = 7
level_3.speed = 16
level_3.events = {{x = 0, y = 32}, {x = 0, y = 33}, {x = 0, y = 34}}
level_3.event_offset = 32
level_3.best_score = -1
level_3.max_score = -1
level_3.saved_score = -1

function init_level(level)
    current_level = level
    debug_pattern_offset = debug_pattern_offset or 0
    gtime = 0
    gstate = 1
    combo_count = 0
    best_combo = 0
    score_count = 0
    final_score = -1
    objects = {}
    particles = {}
    ground_limit = 96
    create(moon, 95, 25)
    --
    menuitem(1, "Restart level", function() init_level(current_level) end)
    menuitem(2, "Back to menu", function() init_menu() end)
    new_highscore = false
    --
    current_runner = create(runner, 24 + debug_pattern_offset*8*32, 88)
    local title = create(textc, 64, 56)
    title.text = level.name
    title.life = 320

    -- tutorial
    if true then
        tuto1 = create(text, 20, 20)
        tuto1.text = "⬆️ => "
        tuto1.spr = apple.spr
        tuto1.life = 510
        tuto2 = create(text, 20, 30)
        tuto2.text = "⬅️ => "
        tuto2.spr = melon.spr
        tuto2.life = 520
        tuto3 = create(text, 20, 40)
        tuto3.text = "➡️ => "
        tuto3.spr = leak.spr
        tuto3.life = 530
    end

    -- gen objects from map
    local event_list_count = 0
    local pixels_per_row = 8
    for event_list in all(level.events) do
        local y = event_list.y
        local x_offset = level.event_offset*8 + event_list_count*8*128
        for i=event_list.x, 127 do
            if mget(i, y) == leak.spr then
                create(leak, i*pixels_per_row + x_offset, ground_limit - leak.hit_h)
            elseif mget(i, y) == melon.spr then
                create(melon, i*pixels_per_row + x_offset, ground_limit - melon.hit_h)
            elseif mget(i, y) == apple.spr then
                create(apple, i*pixels_per_row + x_offset, ground_limit - 2*8 - apple.hit_h)
            end
        end
        event_list_count += 1
    end
    sfx(1, 2, 0, 8)
    music(level.start_music + debug_pattern_offset, 0, level.ch_mask)
end