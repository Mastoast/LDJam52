runner = new_type(4)
runner.hit_w = 8
runner.hit_h = 8
runner.sprs = {4, 5}
runner.anim_time = 7
runner.flr = true
runner.jump_force = -2.9
runner.gravity = 0.20
runner.action_spr = 6
runner.grid_count = 0

function runner.init(self)
    self.speed_x = 1
    self.state = 1
    self.end_anim_time = 0
    self.grid_count = 0
end

function runner.update(self)
    local input_y = 0

    -- fix synch every tick
    local delay = 24 + (stat(56)/current_level.speed) * 8 + (debug_pattern_offset + stat(55)) * 256 - self.x
    if delay >= 2 then
        self.x += 2
    elseif delay > 0 then
        self.x += 1
    end
    
    -- fix synch every pattern
    -- if stat(55) != self.grid_count then
    --     self.grid_count += 1
    --     -- 16 ticks for one row
    --     -- 8 pixels per row
    --     -- 256 pixels per pattern
    --     shake = 0
    --     --self.x = 24 + (stat(56)/current_level.speed) * 8 + stat(55) * 256
    -- end
    
    -- anim
    if gtime <= self.end_anim_time then self.spr = self.action_spr
    elseif gtime%self.anim_time == 0 then
        self.spr = self.sprs[(self.spr + 1)%#self.sprs + 1]
    end

    -- grounded
    if self.y < ground_limit - self.hit_h then
        self.flr = false
    else
        self.flr = true
    end
    -- jump
    if self.flr and btnp(⬆️) then
        self.speed_y = self.jump_force
        --sfx(2, -1, 8, 8)
    end
    -- gravity
    if self.speed_y > 0 then
        self.speed_y += self.gravity*4
    else
        self.speed_y += self.gravity
    end

    self:move_y(self.speed_y)

    if gstate == 2 then return end

    -- harvest :)
    -- can optimize
    if btnp(⬅️) then
        local success = false
        self.end_anim_time = gtime + self.anim_time
        for o in all(objects) do
            if (o.base == melon) and not o.collected and self:overlaps(o) then
                o.collected = true
                spawn_particles(4 + rnd(3), 3, o.x, o.y, 4)
                success = true
                break
            end
        end
        if success then
            create(valid_ui, self.x, self.y)
            score_count += 300
            incr_combo()
        else
            create(invalid_ui, self.x, self.y)
            score_count = max(score_count - 50, 0)
            combo_count = 0
        end
    end

    if btnp(➡️) then
        local success = false
        self.end_anim_time = gtime + self.anim_time
        for o in all(objects) do
            if (o.base == leak) and not o.collected and self:overlaps(o) then
                o.collected = true
                spawn_particles(4 + rnd(3), 3, o.x, o.y, 4)
                success = true
                break
            end
        end
        if success then
            create(valid_ui, self.x, self.y)
            score_count += 300
            incr_combo()
        else
            create(invalid_ui, self.x, self.y)
            score_count = max(score_count - 50, 0)
            combo_count = 0
        end
    end

    if not self.flr then
        for o in all(objects) do
            if (o.base == apple) and not o.collected and self:overlaps(o) then
                o.collected = true
                spawn_particles(4 + rnd(3), 3, o.x, o.y, 8)
                --sfx(2, -1, 0, 8)
                create(valid_ui, self.x, self.y)
                score_count += 300
                incr_combo()
                break
            end
        end
    end
end

function runner.draw(self)
    spr(self.spr, self.x, self.y)
end

function incr_combo()
    combo_count += 1
    if combo_count >= best_combo then best_combo = combo_count end
end