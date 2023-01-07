level_1 = {}
level_1.start_music = 0
level_1.ch_mask = 7
level_1.speed = 16
level_1.length = 128
level_1.events = {x = 0, y = 18}

function init_level(level)
    gtime = 0
    objects = {}
    particles = {}
    ground_limit = 96
    --
    current_runner = create(runner, 24, 88)
    -- gen objects
    for i=level.events.x, 127 do
        for y=level.events.y, 63 do
            if mget(i, y) == leak.spr then
                create(leak, i*level.speed/2, ground_limit - leak.hit_h)
            elseif mget(i, y) == melon.spr then
                create(melon, i*level.speed/2, ground_limit - melon.hit_h)
            elseif mget(i, y) == apple.spr then
                create(apple, i*level.speed/2, ground_limit - 3*8 - apple.hit_h)
            end
        end
    end
    music(level.start_music, 0, level.ch_mask)
end