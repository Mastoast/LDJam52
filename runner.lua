runner = new_type(4)
runner.hit_w = 8
runner.hit_h = 8
runner.type = "runner"

function runner.init(self)
    self.speed_x = 1
    self.state = 3
end

function runner.update(self)

    -- inputs

    self:move_x(self.speed_x)
end

function runner.draw(self)
    spr(self.spr, self.x, self.y)
end