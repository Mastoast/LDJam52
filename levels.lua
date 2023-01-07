function init_level()
    gtime = 0
    objects = {}
    particles = {}
    ground_limit = 96
    --
    current_runner = create(runner, 24, 88)
    -- gen objects
    for i=0, 127 do
        for y=0, 63 do
            if mget(i, y) == leak.spr then
                create(leak, i*8, y*8)
            elseif mget(i, y) == melon.spr then
                create(melon, i*8, y*8)
            elseif mget(i, y) == apple.spr then
                create(apple, i*8, y*8)
            end
        end
    end
    music(0)
end