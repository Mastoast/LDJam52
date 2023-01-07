rectangle = new_type(0)
rectangle.color = 7

function rectangle.draw(self)
    rectfill(self.x, self.y, self.x + self.hit_w - 1, self.y + self.hit_h - 1, self.color)
end

-- FRUITS

function fruit_draw(self)
	if not self.collected then
		spr(self.spr, self.x, self.y, 1, 1)
	else
		spr(self.collected_sprite, self.x, self.y, 1, 1)
	end
end

function fruit_update(self)
	if not self.collected and not self.missed and current_runner.x > self.x + self.hit_w then
		self.missed = true
		create(invalid_ui, self.x, self.y)
	end
end

-- melon
melon = new_type(53)
melon.solid = false
melon.collected_sprite = 54
melon.draw = fruit_draw
melon.update = fruit_update

-- apple
apple = new_type(21)
apple.solid = false
apple.collected_sprite = 22
apple.draw = fruit_draw
apple.update = fruit_update

-- leak
leak = new_type(37)
leak.collected_sprite = 38
leak.solid = false
leak.draw = fruit_draw
leak.update = fruit_update

-- UI
valid_ui = new_type(40)
valid_ui.solid = false
valid_ui.life = 30

function valid_ui.update(self)
	self.y -= 1 * gtime%2
	self.life -= 1
	if self.life == 0 then self.destroyed = true end
end

invalid_ui = new_type(56)
invalid_ui.solid = false
invalid_ui.life = 30
invalid_ui.update = valid_ui.update

-- PARTICLES

particles = {}

-- number of particles
-- size
-- x / y
-- color
function spawn_particles(nb,s,x,y,c)
	for i=1,flr(nb) do
        add(particles, make_particle(s,x,y,c))
	end
end

function make_particle(s,x,y,c)
	local p={
		s=s or 1,
		c=c or 7,
		x=x,y=y,k=k,
		t=0, t_max=16+flr(rnd(4)),
		dx=rnd(2)-1,dy=-rnd(3),
		ddy=0.05,
		update=update_particle,
		draw=draw_particle
	}
	return p
end

function draw_particle(a)
	circfill(a.x,a.y,a.s,a.c)
end

function update_particle(a)
	if a.s>=1 and a.t%4==0 then a.s-=1 end
	if a.t%2==0 then
		a.dy+=a.ddy
		a.x+=a.dx
		a.y+=a.dy
	end
	a.t+=1
	if (a.t==a.t_max) del(particles, a)
end