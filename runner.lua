runner = new_type(4)
runner.hit_w = 8
runner.hit_h = 8
runner.sprs = {4, 5}
runner.anim_time = 7
runner.flr = true
runner.jump_force = -3
runner.gravity = 0.20


function runner.init(self)
    self.speed_x = 1
    self.state = 3
    self.collected_counter = 0
end

function runner.update(self)
    local input_y = 0

    -- anim
    if gtime%self.anim_time == 0 then
        self.spr = self.sprs[(self.spr + 1)%#self.sprs + 1]
    end

    -- grounded
    if self.y < ground_limit - self.hit_h then
        self.flr = false
    else
        self.flr = true
    end
    -- jump
    if self.flr and btnp(🅾️) then
        self.speed_y = self.jump_force
        --sfx(2, -1, 8, 8)
    end
    -- gravity
    if self.speed_y > 0 then
        self.speed_y += self.gravity*2.5
    else
        self.speed_y += self.gravity
    end

    -- harvest :)
    local success = false 
    if btnp(❎) then
        for o in all(objects) do
            if (o.base == leak or o.base == melon) and not o.collected and self:overlaps(o) then
                o.collected = true
                spawn_particles(4 + rnd(3), 3, o.x, o.y, 4)
                --sfx(2, -1, 0, 8)
                self.collected_counter += 1
                success = true
                break
            end
        end
        if success then
            create(valid_ui, self.x, self.y)
        else
            create(invalid_ui, self.x, self.y)
        end
    end

    if not self.flr then
        for o in all(objects) do
            if (o.base == apple) and not o.collected and self:overlaps(o) then
                o.collected = true
                spawn_particles(4 + rnd(3), 3, o.x, o.y, 8)
                --sfx(2, -1, 0, 8)
                self.collected_counter += 1
                create(valid_ui, self.x, self.y)
                break
            end
        end
    end

    self:move_x(self.speed_x)
    self:move_y(self.speed_y)
end

function runner.draw(self)
    spr(self.spr, self.x, self.y)
end