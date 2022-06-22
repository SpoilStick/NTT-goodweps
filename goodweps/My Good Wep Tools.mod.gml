#define init
global.sprLightningShell           = sprite_add("Lightning Shell.png",             2, 8,  8);
global.sprLightningShellDisappear  = sprite_add("Lightning Shell Disappear.png",   5, 8,  8);
global.sprLightningFlakBullet      = sprite_add("Lightning Flak Bullet.png",       1, 8,  8);
global.sprSuperLightningFlakBullet = sprite_add("Super Lightning Flak Bullet.png", 1, 16,16);
#define bullet_hit
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
instance_destroy()

#define bullet_step
if image_index = 1{
	image_speed = 0
}

#define bullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.75*image_xscale, 1.75*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);

#define actually_nothing

#define create_ultra_grenade_cannon_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprAllyBullet;
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 22);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 50;
	scale = 0;
	on_step =    script_ref_create(ultra_grenade_cannon_step);
	on_draw =    script_ref_create(ultra_grenade_cannon_draw);
	on_destroy = script_ref_create(ultra_grenade_cannon_destroy);
}

#define ultra_grenade_cannon_step
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 0.5) {
	speed /= 1.1
}
else {
	instance_destroy();
}
#define ultra_grenade_cannon_destroy
for (var i = random(180); i < 720; i += random(180)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),UltraGrenade){
		motion_set(i, 6+random(10))
		image_angle = direction
		creator = other
		team = other.team
	}
}

#define ultra_grenade_cannon_draw
scale = choose(0.95,1.05);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 1.5 * image_xscale, 1.5 * image_yscale, image_angle, c_lime, 0.75);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2.7*image_xscale, 2.7*image_yscale, image_angle, c_lime, 0.15);
draw_set_blend_mode(bm_normal);

#define create_flame_ball_cannon_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprFireBall;
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 18);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 95;
	scale = 0;
	on_step =    script_ref_create(flame_ball_cannon_step);
	on_draw =    script_ref_create(flame_ball_cannon_draw);
	on_destroy = script_ref_create(flame_ball_cannon_destroy);
}

#define flame_ball_cannon_step
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 1) {
	speed /= 1.11
}
else {
	instance_destroy();
}
#define flame_ball_cannon_destroy
for (var i = random(144); i < 720; i += random(144)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),FlameBall){
		motion_set(i, 16)
		image_angle = direction
		creator = other
		team = other.team
		damage = 20
	}
}

#define flame_ball_cannon_draw
scale = choose(0.85,1.15);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 3 * image_xscale, 3 * image_yscale, image_angle, image_blend, 1.5);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 5.4*image_xscale, 5.4*image_yscale, image_angle, image_blend, 0.375);
draw_set_blend_mode(bm_normal);

#define create_super_flame_flak_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprFireBall
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskSuperFlakBullet
	damage = 95;
	scale = 0;
	dust_scale = 0;
	on_step =    script_ref_create(super_flame_cannon_step);
	on_draw =    script_ref_create(super_flame_cannon_draw);
	on_destroy = script_ref_create(super_flame_cannon_destroy);
}

#define super_flame_cannon_step

if(random(3)<1) {
	with instance_create(x, y, Dust) {
		image_xscale = 1 + random(1)
		image_yscale = 1 + random(1)
	}
}
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 1) {
	speed /= 1.1
}
else {
	instance_destroy();
}
#define super_flame_cannon_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 2 * image_xscale, 2 * image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 3.6*image_xscale, 3.6*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);
#define super_flame_cannon_destroy
for (var j = random_range(-71,0); j < 360; j += 72) {
	with (instance_create(x, y, CustomProjectile)) {
		sprite_index = sprFireBall;
		motion_add(j, 11 + random(2));
		image_angle = direction;
		team = other.team;
		creator = other;
		mask_index = mskFlakBullet
		damage = 18;
		scale = 0;
		on_step =    script_ref_create(flame_cannon_step);
		on_draw =    script_ref_create(flame_cannon_draw);
		on_destroy = script_ref_create(flame_cannon_destroy);
	}
}

#define create_flame_cannon_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprFireBall;
	motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 11 + random(2));
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 18;
	scale = 0;
	on_step =    script_ref_create(flame_cannon_step);
	on_draw =    script_ref_create(flame_cannon_draw);
	on_destroy = script_ref_create(flame_cannon_destroy);
}

#define flame_cannon_step
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 2) {
	speed /= 1.07
}
else {
	instance_destroy();
}
#define flame_cannon_destroy
for (var i = random(72); i < 720; i += random(72)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),FlameShell){
		motion_set(i, 9 + random(4))
		image_angle = direction
		creator = other
		team = other.team
		friction = 0.6
		wallbounce = skill_get(15) * 5
	}
}

#define flame_cannon_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 1*image_xscale, 1*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.8*image_xscale, 1.8*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);

#define create_super_bouncer_cannon
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprAllyBullet
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskSuperFlakBullet
	damage = 95;
	scale = 0;
	dust_scale = 0;
	on_step =    script_ref_create(super_bouncer_cannon_step);
	on_draw =    script_ref_create(super_bouncer_cannon_draw);
	on_destroy = script_ref_create(super_bouncer_cannon_destroy);
}

#define super_bouncer_cannon_step

if(random(3)<1) {
	with instance_create(x, y, Dust) {
		image_xscale = 1 + random(1)
		image_yscale = 1 + random(1)
	}
}
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 1) {
	speed /= 1.1
}
else {
	instance_destroy();
}
#define super_bouncer_cannon_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 2 * image_xscale, 2 * image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 3.6*image_xscale, 3.6*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);
#define super_bouncer_cannon_destroy
for (var j = random_range(-71,0); j < 360; j += 72) {
	with (instance_create(x, y, CustomProjectile)) {
		sprite_index = sprAllyBullet;
		motion_add(j, 11 + random(2));
		image_angle = direction;
		team = other.team;
		creator = other;
		mask_index = mskFlakBullet
		damage = 18;
		scale = 0;
		on_step =    script_ref_create(bouncer_cannon_step);
		on_draw =    script_ref_create(bouncer_cannon_draw);
		on_destroy = script_ref_create(bouncer_cannon_destroy);
	}
}

#define create_bouncer_cannon
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = sprAllyBullet;
	motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 11 + random(2));
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 18;
	scale = 0;
	on_step =    script_ref_create(bouncer_cannon_step);
	on_draw =    script_ref_create(bouncer_cannon_draw);
	on_destroy = script_ref_create(bouncer_cannon_destroy);
}
#define bouncer_cannon_step
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 2) {
	speed /= 1.07
}
else {
	instance_destroy();
}
#define bouncer_cannon_destroy
for (var i = random(72); i < 720; i += random(72)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),BouncerBullet){
		motion_set(i, 5.1 + random(1) - 0.5)
		image_angle = direction
		creator = other
		team = other.team
	}
}

#define bouncer_cannon_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 1*image_xscale, 1*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.8*image_xscale, 1.8*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);

#define create_lightning_explo_rifle
with (instance_create(x+lengthdir_x(8,direction), y+lengthdir_y(8,direction), CustomProjectile)) {
	sprite_index = global.sprLightningFlakBullet;
	motion_add(other.gunangle, 16);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 55;
	on_draw =    script_ref_create(lightning_explo_rifle_bullet_draw);
	on_destroy = script_ref_create(lightning_explo_rifle_bullet_destroy);
}
#define lightning_explo_rifle_bullet_draw

draw_sprite_ext(sprite_index, image_index, x, y, 1.5*image_xscale, 1.5*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 4*image_xscale, 4*image_yscale, image_angle, image_blend, 0.3);
draw_set_blend_mode(bm_normal);

#define lightning_explo_rifle_bullet_destroy

with instance_create(x, y, PortalClear) {
	image_xscale = 1.3
	image_yscale = 1.3
}
for (var k = 45 + random(30); k < 720; k += 45 + random(30)) {
	with instance_create(x,y,Lightning){
		image_angle = k
		creator = other.creator
		team = other.team
		ammo = 20
		alarm0 = 1
		visible = 0
		damage = 30
		with instance_create(x,y,LightningSpawn)
		{
			image_angle = other.image_angle
			damage = 30
		}
		sound_play(sndLightningPistol)
	}
}
#define create_lightning_shot_cannon

with (instance_create(x, y, CustomObject)) {
	sprite_index = global.sprSuperLightningFlakBullet;
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 20);
	image_angle = direction;
	team = other.team;
	creator = other;
	damage = 0;
	scale = 0;
	dust_scale = 0;
	timer = 0;
	lifetimer = -150;
	on_step =    script_ref_create(lightning_shot_cannon_step);
	on_destroy = script_ref_create(lightning_shot_cannon_destroy);
	on_draw =    script_ref_create(super_lightning_flak_bullet_draw);
}

#define lightning_shot_cannon_step

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}
if (speed > 0.1) {
	speed /= 1.1
}
else {
	if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
	else {
	lifetimer += 100
	gunangle = random(359)
	}
	if (timer >= 2) {
		for(var j = -15; j <= 15; j += 15) {
			with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),CustomProjectile){
				motion_set(j + other.gunangle + (random(6) - 3), 14  + random(2))
				sprite_index = global.sprLightningShell
				friction = .6
				image_angle = direction
				mask_index = mskBullet2
				creator = other
				team = other.team
				wallbounce = skill_get(17) * 5
				recycle_amount = 0
				image_speed = 1
				damage = 5
				on_step    = script_ref_create(lightning_shell_step)
				on_destroy = script_ref_create(lightning_shell_destroy)
				on_draw    = script_ref_create(lightning_shell_draw)
			}
		}
		timer = 0
	}
	else timer += 1
}
if (lifetimer > 0) {
	instance_destroy();
}
else lifetimer += 1

#define lightning_shot_cannon_destroy
for (var i = random(25); i < 720; i += random(25)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),CustomProjectile){
		motion_set(i, 12  + random(8))
		sprite_index = global.sprLightningShell
		friction = .6
		image_angle = direction
		mask_index = mskBullet2
		creator = other
		team = other.team
		wallbounce = skill_get(17) * 5
		recycle_amount = 0
		image_speed = 1
		damage = 5
		on_step    = script_ref_create(lightning_shell_step)
		on_destroy = script_ref_create(lightning_shell_destroy)
		on_draw    = script_ref_create(lightning_shell_draw)
	}
}
#define lightning_explo_bullet_draw

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 3*image_xscale, 3*image_yscale, image_angle, image_blend, 0.4);
draw_set_blend_mode(bm_normal);

#define lightning_explo_bullet_destroy

with instance_create(x, y, PortalClear) {
	image_xscale = 1.2
	image_yscale = 1.2
}
for (var k = random(100); k < 360; k += random(100)) {
	with instance_create(x,y,Lightning){
		image_angle = k
		creator = other.creator
		team = other.team
		ammo = 6
		alarm0 = 1
		visible = 0
		damage = 10
		with instance_create(x,y,LightningSpawn)
		{
		   image_angle = other.image_angle
		   damage = 10
		}
		sound_play(sndLightningPistol)
	}
}

#define create_super_lightning_flak_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = global.sprSuperLightningFlakBullet;
	motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16);
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskSuperFlakBullet
	damage = 95;
	scale = 0;
	dust_scale = 0;
	on_step =    script_ref_create(super_lightning_flak_bullet_step);
	on_draw =    script_ref_create(super_lightning_flak_bullet_draw);
	on_destroy = script_ref_create(super_lightning_flak_bullet_destroy);
}

#define super_lightning_flak_bullet_step
if(random(3)<1) {
	with instance_create(x, y, Dust) {
		image_xscale = 1 + random(1)
		image_yscale = 1 + random(1)
	}
}
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 1) {
	speed /= 1.1
}
else {
	instance_destroy();
}
#define super_lightning_flak_bullet_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.75*image_xscale, 1.75*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);
#define super_lightning_flak_bullet_destroy
for (var j = random_range(-71,0); j < 360; j += 72) {
	with (instance_create(x, y, CustomProjectile)) {
		sprite_index = global.sprLightningFlakBullet;
		motion_add(j, 12);
		image_angle = direction;
		team = other.team;
		creator = other;
		mask_index = mskFlakBullet
		damage = 18;
		scale = 0;
		on_step =    script_ref_create(lightning_flak_bullet_step);
		on_draw =    script_ref_create(lightning_flak_bullet_draw);
		on_destroy = script_ref_create(lightning_flak_bullet_destroy);
	}
}

#define create_lightning_flak_bullet
with (instance_create(x, y, CustomProjectile)) {
	sprite_index = global.sprLightningFlakBullet;
	motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 11 + random(2));
	image_angle = direction;
	team = other.team;
	creator = other;
	mask_index = mskFlakBullet
	damage = 18;
	scale = 0;
	on_step =    script_ref_create(lightning_flak_bullet_step);
	on_draw =    script_ref_create(lightning_flak_bullet_draw);
	on_destroy = script_ref_create(lightning_flak_bullet_destroy);
}
#define lightning_flak_bullet_step
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
if (speed > 2) {
	speed /= 1.07
}
else {
	instance_destroy();
}
#define lightning_flak_bullet_draw
scale = choose(0.9,1.1);
image_xscale = scale;
image_yscale = scale;
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.75*image_xscale, 1.75*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);
#define lightning_flak_bullet_destroy
for (var i = random(90); i < 720; i += random(90)) {
	with instance_create(x+lengthdir_x(1,direction),y+lengthdir_y(1,direction),CustomProjectile){
		motion_set(i, 9  + random(4))
		sprite_index = global.sprLightningShell
		friction = .6
		image_angle = direction
		mask_index = mskBullet2
		creator = other
		team = other.team
		wallbounce = skill_get(17) * 5
		recycle_amount = 0
		image_speed = 1
		damage = 5
		on_step    = script_ref_create(lightning_shell_step)
		on_destroy = script_ref_create(lightning_shell_destroy)
		on_draw    = script_ref_create(lightning_shell_draw)
	}
}
#define lightning_shell_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 3*image_xscale, 3*image_yscale, image_angle, image_blend, 0.15);
draw_set_blend_mode(bm_normal);
#define lightning_shell_step
if image_index >= 1{
	image_speed = 0
}
if place_meeting(x + hspeed, y, Wall){
	hspeed /= -1.25
	if speed + wallbounce >= 18{
	speed = 18
	}
	else{
		speed += wallbounce
	}
	wallbounce /= 1.05
	instance_create(x,y,Dust)
	sound_play(sndShotgunHitWall)
	image_angle = direction
}
if place_meeting(x, y + vspeed, Wall){
	vspeed /= -1.25
	if speed + wallbounce >= 18{
	speed = 18
	}
	else{
		speed += wallbounce
	}
	wallbounce /= 1.05
	instance_create(x,y,Dust)
	sound_play(sndShotgunHitWall)
	image_angle = direction
}
if place_meeting(x + hspeed, y + vspeed, Wall){
	direction += 180
	speed /= 1.25
	if speed + wallbounce >= 18{
	speed = 18
	}
	else{
		speed += wallbounce
	}
	wallbounce /= 1.05
	instance_create(x,y,Dust)
	sound_play(sndShotgunHitWall)
	image_angle = direction
}
if speed < 3{
	instance_destroy()
}

#define lightning_shell_destroy
with instance_create(x,y,BulletHit){
	sprite_index = global.sprLightningShellDisappear
	speed = other.speed/5
	direction = other.direction
	image_angle = direction
}
with instance_create(x,y,Lightning){
	image_angle = random(360)
	creator = other.creator
	team = other.team
	ammo = 6
	alarm0 = 1
	visible = 0
	with instance_create(x,y,LightningSpawn)
	{
	   image_angle = other.image_angle
	}
	sound_play(sndLightningPistol)
}