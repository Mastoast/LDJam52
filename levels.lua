level_1 = {}
level_1.start_music = 0
level_1.ch_mask = 7
level_1.speed = 16
level_1.length = 320
level_1.events = {{x = 0, y = 18}, {x = 0, y = 19}}
level_1.event_offset = 64

function init_level(level, debug_offset)
    debug_offset = debug_offset or 6
    gtime = 0
    objects = {}
    particles = {}
    ground_limit = 96
    --
    current_runner = create(runner, 24 + debug_offset*8*32, 88)
    -- gen objects
    local event_list_count = 0
    for event_list in all(level.events) do
        local y = event_list.y
        local x_offset = level.event_offset*8 + event_list_count*8*127
        for i=event_list.x, 127 do
            if mget(i, y) == leak.spr then
                create(leak, i*level.speed/2 + x_offset, ground_limit - leak.hit_h)
            elseif mget(i, y) == melon.spr then
                create(melon, i*level.speed/2 + x_offset, ground_limit - melon.hit_h)
            elseif mget(i, y) == apple.spr then
                create(apple, i*level.speed/2 + x_offset, ground_limit - 2*8 - apple.hit_h)
            end
        end
        event_list_count += 1
    end
    music(level.start_music + debug_offset, 0, level.ch_mask)
end