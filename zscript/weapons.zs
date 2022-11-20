#include "zscript/weapons/mini_crossbow.zs"
#include "zscript/weapons/pistol.zs"
#include "zscript/weapons/stealth_pistol.zs"
#include "zscript/weapons/ps20.zs"

#include "zscript/weapons/assault_rifle.zs"
#include "zscript/weapons/assault_shotgun.zs"
#include "zscript/weapons/sawed_off_shotgun.zs"
#include "zscript/weapons/sniper_rifle.zs"

#include "zscript/weapons/riot_prod.zs"
#include "zscript/weapons/dragons_tooth_sword.zs"
#include "zscript/weapons/baton.zs"
#include "zscript/weapons/combat_knife.zs"
#include "zscript/weapons/crowbar.zs"
#include "zscript/weapons/sword.zs"
#include "zscript/weapons/throwing_knives.zs"
#include "zscript/weapons/pepper_gun.zs"

#include "zscript/weapons/lam.zs"
#include "zscript/weapons/gas_grenade.zs"
#include "zscript/weapons/emp_grenade.zs"
#include "zscript/weapons/scramble_grenade.zs"

#include "zscript/weapons/plasma_rifle.zs"
#include "zscript/weapons/law.zs"
#include "zscript/weapons/flamethrower.zs"
#include "zscript/weapons/gep_gun.zs"

class DDWeapon : DoomWeapon
{
	default
	{
		Inventory.PickupSound "DDWeapon/weapon_pickup";

		Weapon.AmmoUse 1;
		Weapon.AmmoGive 0;
		+Weapon.AMMO_OPTIONAL;
		+Weapon.NOALERT;

		DDWeapon.AccurateRange 1024;
		DDWeapon.MaxRange 2048;

		DDweapon.MaxBonusClip 7;
	}

	override void BeginPlay()
	{
		super.BeginPlay();
		lastvel = vel;
		SetDropRotation();

		let sk = DD_EventHandler(StaticEventHandler.Find("DD_EventHandler")).skill_utils;
		for(uint i = 0; i < sk.skills.size(); ++i)
			if(_skill == sk.skills[i]._name)
			{ skill_id = i; break; }

		current_ammo_type = ammo_type1;
		AmmoType1 = current_ammo_type;
		AmmoType1 = ammo_type1;

		if(base_clip2 == 0) base_clip2 = base_clip;
		if(base_clip3 == 0) base_clip3 = base_clip;

		angle_sign = pitch_sign = 1;

		chambered_ammo = random(ceil(GetClipSize() / 3.), GetClipSize());
	}

	override void Tick()
	{
		super.Tick();
		CheckDropSound();
		CheckDropRotation();
		CheckAimSpread();
		CheckRecoil();
		SpawnLaser();
		CheckInvDispDesc();
		DoScopeSway();
		CheckLockOn();

	}

	string _skill;
	property Skill: _skill;
	int skill_id;

	clearscope int GetSkillLevel()
	{
		let sk = DD_EventHandler(StaticEventHandler.Find("DD_EventHandler")).skill_utils;
		return sk.getPlayerSkillLevel(PlayerPawn(owner), skill_id);
	}

	bool toss_one;
	property TossOne : toss_one;
	override Inventory CreateTossable(int amt)
	{
		DDWeapon ret = DDWeapon(super.CreateTossable(amt));
		ret.base_spread = base_spread;
		ret.bonus_clip = bonus_clip;
		ret.recoil = recoil;
		ret.has_silencer = has_silencer;
		ret.has_laser = has_laser;
		ret.chambered_ammo = chambered_ammo;
		if(!toss_one)
			ret.amount = amount;
		else
			ret.amount = 1;
		return ret;
	}


	/* Drop sound */
	string drop_sound;
	property DropSound : drop_sound;

	vector3 lastvel;
	void CheckDropSound()
	{
		if(lastvel.length() > 0 && vel.length() == 0)
			A_StartSound(drop_sound);
		lastvel = vel;
	}

	/* Drop rotation */
	double desired_angle, spin_per_tick;
	const spin_time = 8;
	void SetDropRotation()
	{
		spriteRotation = frandom(-180, 180);
		desired_angle = spriteRotation + frandom(90, 180) * (random(0, 1) ? 1 : -1);
		spin_per_tick = (desired_angle - spriteRotation) / spin_time;
	}
	void CheckDropRotation()
	{
		if(spriteRotation != desired_angle)
			spriteRotation += spin_per_tick;
		if(vel.length() == 0)
			desired_angle = spriteRotation;
	}

	/* Animations */
	int idle_state_amt;
	property IdleStateAmount : idle_state_amt; // can't really generate state labels, so it has a set maximum of 3 (DX doesn't use more anyway)

	action State TryPlayIdleAnim(int inv_chance = 256)
	{
		if(random(0, inv_chance) || !invoker.idle_state_amt) return ResolveState(Null);
		switch(random(0, invoker.idle_state_amt - 1)){
			case 0: return ResolveState("Idle1");
			case 1: return ResolveState("Idle2");
			case 2: return ResolveState("Idle3");
		}
		return ResolveState(null);
	}

	int fire_state_amt;
	property FireStateAmount : fire_state_amt;
	action State PlayFireAnim()
	{
		switch(random(0, invoker.fire_state_amt - 1)){
			case 0: return ResolveState("Fire1");
			case 1: return ResolveState("Fire2");
			case 2: return ResolveState("Fire3");
		}
		return ResolveState(null);
	}

	const place_range = 64;
	action State HandlePlaceAnim(StateLabel place_state = "Place", StateLabel else_state = null)
	{
		vector3 dir = (Actor.AngleToVector(angle, cos(pitch)), -sin(pitch));
		let aim_tracer = new("DD_AimTracer");
		aim_tracer.source = self;
		aim_tracer.trace(pos + (0, 0, player.viewHeight), curSector, dir, place_range, 0);
		if(aim_tracer.hit_wall)
			return ResolveState(place_state);
		return ResolveState(else_state);
	}

	/* Clip */
	name ammo_type1;
	property AmmoType1 : ammo_type1;
	name ammo_type2;
	property AmmoType2 : ammo_type2;
	name ammo_type3;
	property AmmoType3 : ammo_type3;

	name current_ammo_type;
	int chambered_ammo;

	bool ChangeAmmoType(Name to)
	{
		if(!to || !owner.countInv(to))
			return false;
		if(chambered_ammo > 0){
			owner.A_GiveInventory(current_ammo_type, chambered_ammo);
			chambered_ammo = 0;
		}
		current_ammo_type = to;
		return true;
	}
	void CycleAmmoType()
	{
		if(current_ammo_type == ammo_type1) ChangeAmmoType(ammo_type2) ? (0) : ChangeAmmoType(ammo_type3);
		else if(current_ammo_type == ammo_type2) ChangeAmmoType(ammo_type3) ? (0) : ChangeAmmoType(ammo_type1);
		else if(current_ammo_type == ammo_type3) ChangeAmmoType(ammo_type1) ? (0) : ChangeAmmoType(ammo_type2);
		AmmoType1 = current_ammo_type;
	}

	int base_clip;
	int base_clip2;
	int base_clip3;
	property BaseClipSize : base_clip;
	property BaseClipSize2 : base_clip2;
	property BaseClipSize3 : base_clip3;
	int bonus_clip;
	int max_bonus_clip;
	property MaxBonusClip : max_bonus_clip;
	virtual clearscope int GetBonusClipPerUpgrade() { return 1; }
	clearscope int GetClipSize()
	{
		return (current_ammo_type == ammo_type1 ? base_clip
			: current_ammo_type == ammo_type2 ? base_clip2
			: base_clip3)
				+ (bonus_clip * GetBonusClipPerUpgrade());
	}

	action State CheckClipAmmo(StateLabel dry_fire_state)
	{
		if(invoker.chambered_ammo <= 0)
			return ResolveState(dry_fire_state);
		return ResolveState(Null);
	}
	action void ReloadClip(int max_amount = 0xFFFFFFF)
	{
		int amt = invoker.GetClipSize() - invoker.chambered_ammo;
		amt = amt > max_amount ? max_amount : amt;
		amt = amt <= CountInv(invoker.current_ammo_type) ? amt : CountInv(invoker.current_ammo_type);
		if(amt > 0){
			invoker.chambered_ammo += amt;
			A_TakeInventory(invoker.current_ammo_type, amt);
		}
	}

	/* Reloading */
	int reload_timer;
	int base_reload_time;
	property BaseReloadTime : base_reload_time;
	int reload_time_decrease;

	clearscope int GetTotalReloadTime()
	{
		return base_reload_time - reload_time_decrease - (GetSkillLevel() / 6.) * base_reload_time;
	}

	action State AdvanceReloadTimer(int tick_amt, StateLabel reload_end_state)
	{
		invoker.reload_timer += tick_amt;
		if(invoker.reload_timer >= invoker.GetTotalReloadTime()){
			invoker.reload_timer = 0;
			return ResolveState(reload_end_state);
		}
		return ResolveState(Null);
	}

	/* Recoil */
	double recoil;
	property Recoil : recoil;
	double pitch_shift_left;
	const pitch_shift_rate = 3;

	clearscope double GetRecoil() { return recoil - GetSkillLeveL() * 4; }

	action void DoRecoil(double mult = 1.0)
	{
		invoker.pitch_shift_left = invoker.GetRecoil() * mult;
	}
	void CheckRecoil()
	{
		if(pitch_shift_left > 0){
			owner.A_SetPitch(owner.pitch - pitch_shift_rate);
			pitch_shift_left -= pitch_shift_rate;
		}
	}

	/* GEP Gun lock-on */
	bool has_lockon;
	property HasLockOn: has_lockon;
	clearscope int GetLockOnTime() { return 90 - GetSkillLevel() * 24; }
	int lockon_timer;

	clearscope bool IsLockedOn() { return lockon_timer >= GetLockOnTime(); }

	int lockon_beep_timer;
	void CheckLockOn()
	{
		if(!owner || owner.player.ReadyWeapon != self)
			return;
		if(lockon_timer >= GetLockOnTime() * 0.25){
			int beep_time = 30 * 0.55**(double(lockon_timer) / GetLockOnTime() * 3.5);
			if(beep_time > 25) beep_time = 25;
			if(beep_time < 4) beep_time = 3;
			if(lockon_beep_timer < beep_time)
				++lockon_beep_timer;
			else{
				if(IsLockedOn())
					owner.A_StartSound("DDWeapon_GEPGun/lockon", CHAN_AUTO, CHANF_DEFAULT, 0.7);
				else
					owner.A_StartSound("DDWeapon_GEPGun/track", CHAN_AUTO);
				lockon_beep_timer = 0;
			}
		}
	}

	/* Spread */
	double base_spread;
	property BaseSpread : base_spread;

	const max_vel_spread = 1.5;

	clearscope double GetBaseSpread() { return base_spread * (has_laser ? 0.5 : 1) - GetSkillLevel() * 2.35; }
	clearscope double GetCurrentSpread()
	{
		double vel_spread = 1 + owner.vel.length() ** 0.5 / 7;
		if(vel_spread > max_vel_spread) vel_spread = max_vel_spread;
		double ret = GetBaseSpread() * vel_spread - aim_spread_off;
		return ret > 0 ? ret : 0;
	}

	Actor aimed_at;
	Actor last_valid_target;
	double aim_spread_off;
	const max_aim_spread_off = 12.0;
	const aim_spread_dec_per_tick = 0.18;
	const aim_spread_inc_per_tick = 0.18;

	void CheckAimSpread()
	{
		if(!owner)
			return;
		let aim_tracer = new("DD_AimTracer");
		aim_tracer.source = owner;
		vector3 dir = (Actor.AngleToVector(owner.angle, cos(owner.pitch)), -sin(owner.pitch));
		aim_tracer.trace(owner.pos + (0, 0, PlayerPawn(owner).viewHeight), owner.curSector, dir, max_range, 0);

		if(aimed_at != aim_tracer.hit_obj){ // new target
			if(aim_tracer.hit_obj && last_valid_target){ // decrease aim spread reduce by distance between 2 entities
				aim_spread_off -= (aim_tracer.hit_obj.distance3D(last_valid_target)) ** 0.8 / 32;
			}
		}
		else if(aimed_at){ // increase aim spread reduce by fixed amount, if there is a valid target
			aim_spread_off += aim_spread_dec_per_tick;
			if(has_lockon && lockon_timer < GetLockOnTime() * 2.25)
				++lockon_timer;
		}
		else{ // no target, decrease aim spread reduce
			aim_spread_off -= aim_spread_inc_per_tick;
			if(has_lockon && lockon_timer > 0){
				lockon_timer -= 2;
				if(lockon_timer < 0) lockon_timer = 0;
			}
		}

		// update targets
		if(aimed_at)
			last_valid_target = aimed_at;
		aimed_at = aim_tracer.hit_obj;
		// truncate
		if(aim_spread_off > max_aim_spread_off) aim_spread_off = max_aim_spread_off;
		if(aim_spread_off < 0) aim_spread_off = 0;
	}

	/* Upgrades */
	bool deny_upgrades;
	property DenyUpgrades : deny_upgrades;

	/* Silencer */
	bool has_silencer;
	property HasSilencer : has_silencer;
	bool can_install_silencer;
	property CanInstallSilencer : can_install_silencer;
	action void AlertSilencerCheck()
	{
		if(!invoker.has_silencer)
			A_AlertMonsters();
	}

	/* Laser */
	bool has_laser;
	void SpawnLaser()
	{
		if(has_laser && owner && owner.player.readyWeapon == self){
			vector3 dir = (AngleToVector(owner.angle, cos(owner.pitch)), -sin(owner.pitch));
			DD_AimTracer aim_tracer = new("DD_AimTracer");
			aim_tracer.source = owner;
			aim_tracer.trace(owner.pos + (0, 0, PlayerPawn(owner).viewHeight), owner.curSector, dir, max_range, 0);
			owner.A_SpawnParticle("Red", SPF_FULLBRIGHT | SPF_NOTIMEFREEZE, 1, 20, 0, aim_tracer.results.hitpos.x - owner.pos.x, aim_tracer.results.hitpos.y - owner.pos.y, aim_tracer.results.hitpos.z - owner.pos.z);
		}
	}

	/* Scope */
	bool has_scope;
	property HasScope : has_scope;
	bool zoomed_in;
	int zoom_fov;
	property ScopeFOV : zoom_fov;

	action void ToggleScope()
	{
		if(invoker.has_scope){
			invoker.zoomed_in = !invoker.zoomed_in;
			if(invoker.zoomed_in)
				invoker.FOVScale = invoker.zoom_fov / player.FOV;
			else
				invoker.FOVScale = 1;
		}
	}
	action void LowerScope()
	{
		if(invoker.has_scope && invoker.zoomed_in)
			ToggleScope();
	}

	double angle_change, pitch_change;
	double angle_sign, pitch_sign;
	const angle_mul = 0.65; const pitch_mul = 0.55;
	const angle_pertick_mul = 0.02 * angle_mul; const pitch_pertick_mul = 0.02 * pitch_mul;
	const sway_min_spread = 4;
	void DoScopeSway()
	{
		if(owner && has_scope && zoomed_in && GetBaseSpread() >= sway_min_spread){
			double spr = GetBaseSpread();
			if(angle_change > 0){
				owner.A_SetAngle(owner.angle + angle_sign * angle_pertick_mul * spr, SPF_INTERPOLATE);
				angle_change -= angle_pertick_mul * spr;
			}
			else{
				angle_change = frandom(0, spr) * angle_mul;
				angle_sign *= -1;
			}
			if(pitch_change > 0){
				owner.A_SetPitch(owner.pitch + pitch_sign * pitch_pertick_mul * spr, SPF_INTERPOLATE);
				pitch_change -= pitch_pertick_mul * spr;
			}
			else{
				pitch_change = frandom(-spr, spr) * pitch_mul;
				pitch_sign *= -1; 
			}
		}
	}

	/* Weapon description on inventory display */
	void CheckInvDispDesc()
	{
		if(owner){
			let ddih = DD_InventoryHolder(owner.FindInventory("DD_InventoryHolder"));
			for(uint i = 0; i < ddih.items.size(); ++i)
				if(ddih.items[i].item == self){
					if(GetBulletAmount() == 1)
						ddih.items[i].desc = String.Format("%s\n\n"
														"Damage: %.0f\n"
														"Spread: %.1f ANG\n"
														"Clip: %d RDS\n"
														"Reload time: %.1f s\n"
														"Recoil: %.1f N"
														, ddih.items[i].base_desc
														, GetMainDamage(),
														GetBaseSpread() > 0 ? GetBaseSpread() : 0,
														GetClipSize(),
														GetTotalReloadTime() > 0 ? (GetTotalReloadTime() / 35.) : 0,
														GetRecoil() > 0 ? GetRecoil() : 0);
					else
						ddih.items[i].desc = String.Format("%s\n\n"
														"Damage: %.0fx%d\n"
														"Spread: %.1f ANG\n"
														"Clip: %d RDS\n"
														"Reload time: %.1f s\n"
														"Recoil: %.1f N"
														, ddih.items[i].base_desc
														, GetMainDamage(), GetBulletAmount(),
														GetBaseSpread() > 0 ? GetBaseSpread() : 0,
														GetClipSize(),
														GetTotalReloadTime() > 0 ? (GetTotalReloadTime() / 35.) : 0,
														GetRecoil() > 0 ? GetRecoil() : 0);
					break;
				}
		}
	}

	/* Heavy weapons slowdown */
	override double GetSpeedFactor()
	{
		if(_skill != "Weapons: Heavy" || owner.player.ReadyWeapon != self)
			return 1;
		double ms = 0.45 + GetSkillLevel() * 0.3;
		return ms > 1 ? 1 : ms;
	}

	/* Attacks */
	double main_damage;
	property MainDamage : main_damage;

	virtual double GetDamageMult() { return 1; }
	action double GetMainDamage()
	{
		double dmult = 1 + invoker.GetSkillLevel() / 3.;
		return invoker.main_damage * dmult * invoker.GetDamageMult();
	}
	virtual int GetBulletAmount() { return 1; }

	int accurate_range;
	property AccurateRange : accurate_range;
	int max_range;
	property MaxRange : max_range;

	virtual int GetPenetrationAmount() { return 1; }


	void SprayDecal(string type, double angle, double pitch)
	{
		if(owner){
			warp(owner, 0, 0, owner.player.viewHeight - 8);
			self.angle = 0; self.pitch = 0;
			vector3 dir = (Actor.AngleToVector(angle, cos(pitch)), -sin(pitch));
			A_SprayDecal(type, max_range, (0, 0, 0), dir);
		}
	}


	const FLAG_DONTPUFF = 1;
	action void HitscanAttack(int base_damage = -1, int bullet_amt = -1, int pen_amt = -1, class<Inventory> give_powerup = "",
								string hit_flesh_sound = "", string hit_metal_sound = "", string hit_wall_sound = "", int flags = 0)
	{
		if(base_damage == -1) base_damage = GetMainDamage();
		if(bullet_amt == -1) bullet_amt = invoker.GetBulletAmount();
		if(pen_amt == -1) pen_amt = invoker.GetPenetrationAmount();

		if(countInv("PowerStrength") && invoker.bMELEEWEAPON)
			base_damage *= 1.5;

		for(int i = 0; i < bullet_amt; ++i){
			let aim_tracer = new("DD_AimTracer");
			aim_tracer.source = self;
			double spread_x = invoker.getCurrentSpread();
			double spread_y = invoker.getCurrentSpread();
			if(invoker.has_scope && invoker.zoomed_in)
				spread_x = spread_y = 0;

			double angle = angle + frandom(-spread_x, spread_x);
			double pitch = pitch + frandom(-spread_y, spread_y);
			A_FireBullets(angle, pitch, 0, 0, "DD_NoPuff", FBF_EXPLICITANGLE | FBF_NOFLASH | FBF_NORANDOMPUFFZ, invoker.max_range); // Trigger switches
			vector3 dir = (Actor.AngleToVector(angle, cos(pitch)), -sin(pitch));
			for(int i = 0; i < pen_amt; ++i){
				aim_tracer.trace(pos + (0, 0, player.viewHeight), curSector, dir, invoker.max_range, 0);
				double dmg = base_damage;
				if(aim_tracer.hit_obj){
					aim_tracer.toskip = aim_tracer.hit_obj;
					// Deus Ex drops off the hitscan destination itself, but since I am not implementing headshots, damage is reduced using the same formula
					// https://deusex.fandom.com/wiki/Range_(DX)
					if(Distance3D(aim_tracer.hit_obj) > invoker.max_range)
						dmg = 0;
					else if(Distance3D(aim_tracer.hit_obj) > invoker.accurate_range)
						dmg -= dmg * ((Distance3D(aim_tracer.hit_obj) - invoker.accurate_range) / (invoker.max_range - invoker.accurate_range)) ** 2;

					bool noblood = aim_tracer.hit_obj.bNOBLOOD;
					bool isboss = aim_tracer.hit_obj.bBOSS;
					aim_tracer.hit_obj.DamageMobj(self, self, dmg, "None");
					if(!aim_tracer.hit_obj){ // Object disappeared after taking damage. COULD HAPPEN.

						if((noblood || isboss) && hit_metal_sound)
							A_StartSound(hit_metal_sound);
						else if(!noblood && hit_flesh_sound)
							A_StartSound(hit_flesh_sound);
						continue;
					}

					if(give_powerup){
						let existing_pu = aim_tracer.hit_obj.FindInventory(give_powerup);
						if(existing_pu){
							existing_pu.DetachFromOwner();
							existing_pu.Destroy();
						}
						let pu = Inventory(Actor.Spawn(give_powerup));
						aim_tracer.hit_obj.addInventory(pu);
					}

					if((noblood || isboss) && hit_metal_sound)
						A_StartSound(hit_metal_sound);
					else if(!noblood && hit_flesh_sound)
						A_StartSound(hit_flesh_sound);
				}
				else if(aim_tracer.hit_wall && hit_wall_sound)
					A_StartSound(hit_wall_sound);

				// Spawn bullet puff
				if((aim_tracer.hit_wall || aim_tracer.hit_obj) && !(flags & FLAG_DONTPUFF))
					Spawn("BulletPuff", (aim_tracer.results.hitpos.x, aim_tracer.results.hitpos.y, aim_tracer.results.hitpos.z) - dir);
				// Spawn decal
				if(aim_tracer.hit_wall && !(flags & FLAG_DONTPUFF))
					invoker.SprayDecal("DDDecal_BulletChip", angle, pitch);

				aim_tracer.hit_obj = null;
			}
		}
		if(invoker.chambered_ammo > 0)
			--invoker.chambered_ammo;
		AlertSilencerCheck();
	}

	action DDProjectile ProjectileAttack(class<DDProjectile> projtype, int base_damage, bool consume_ammo = true, vector3 off = (0, 0, 0))
	{
		double ang = frandom(-invoker.getCurrentSpread(), invoker.getCurrentSpread());
		double _pitch = frandom(-invoker.getCurrentSpread(), invoker.getCurrentSpread());
		DDProjectile proj = DDProjectile(Actor.Spawn(projtype));
		proj.target = invoker.owner;
		proj.warp(invoker.owner, proj.vel.x * 3, proj.vel.y * 3, proj.vel.z * 3 + invoker.owner.player.viewHeight + off.z);
		proj.angle = invoker.owner.angle + ang; proj.pitch = invoker.owner.pitch + _pitch;
		proj._damage = base_damage;
		proj.A_ChangeVelocity(proj.speed * cos(proj.pitch), 0, proj.speed * -sin(proj.pitch), CVF_RELATIVE);
		proj.warp(proj, off.x, off.y, 0);
		proj.pitch = 0;
		if(consume_ammo && invoker.chambered_ammo > 0)
			--invoker.chambered_ammo;
		AlertSilencerCheck();

		return proj;
	}

	action void PlaceProjectile(class<DDProjectile> projtype, int base_damage)
	{
		vector3 dir = (Actor.AngleToVector(angle, cos(pitch)), -sin(pitch));

		DDProjectile proj = DDProjectile(Actor.Spawn(projtype));
		proj.target = invoker.owner;
		proj.warp(invoker.owner, 0, 0, invoker.owner.player.viewHeight);
		for(uint i = 0; i < 100 && proj.Warp(proj, dir.x, dir.y, dir.z, angle, WARPF_ABSOLUTEOFFSET | WARPF_ABSOLUTEANGLE); ++i)
			;
		proj._damage = base_damage;
		proj.in_wall = true;
		if(invoker.chambered_ammo > 0)
			--invoker.chambered_ammo;
	}

	// Tracked parameters for SwipeAttack(), if multiple instances are used (like for DTS)
	array<Actor> swipe_hit;
	bool swipe_hit_wall;
	action void ClearSwipeAttack() { invoker.swipe_hit.clear(); invoker.swipe_hit_wall = false;}

	action void SwipeAttack(double angle_off, double arc_angle,
							string hit_flesh_sound = "", string hit_metal_sound = "", string hit_wall_sound = "")
	{
		int base_damage = invoker.GetMainDamage();
		int reach = invoker.max_range;
		ThinkerIterator ti = ThinkerIterator.Create();
		int hit_flags = 0;
		Actor a;
		while(a = Actor(ti.next())){
			double dist = Distance3D(a);
			if(dist - a.radius > invoker.max_range * 2)
				continue;
			if((!a.bSHOOTABLE && !a.bMISSILE) || invoker.swipe_hit.find(a) != invoker.swipe_hit.size() || a == self)
				continue;
			double ang_to = Normalize180(angle - AngleTo(a));
			if(ang_to >= angle_off && ang_to <= angle_off + arc_angle){
				if(a.bMISSILE){
					a.die(self, self);
					continue;
				}

				if(dist - a.radius > invoker.max_range)
					continue;
				vector3 dir = Vec3To(a);
				if(dir.length() != 0) dir /= dir.length();
				double look_pitch = asin(dir dot (0, 0, 1));
				if(abs(look_pitch + pitch) >= 60 || !CheckSight(a))
					continue;
			
				a.DamageMobj(self, self, base_damage, "None");
				bool noblood = a.bNOBLOOD;
				bool isboss = a.bBOSS;
				if((noblood || isboss) && hit_metal_sound){
					hit_flags |= 2; // hit metal
					invoker.swipe_hit_wall = true;
				}
				else if(!noblood && hit_flesh_sound){
					hit_flags |= 1; // hit flesh
					invoker.swipe_hit_wall = true;
				}
				invoker.swipe_hit.push(a);
			}
		}
		// Check if also hit a wall
		if(!invoker.swipe_hit_wall){
			let aim_tracer = new("DD_AimTracer");
			aim_tracer.source = self;
			vector3 dir = (Actor.AngleToVector(angle, cos(pitch)), -sin(pitch));
			aim_tracer.trace(pos + (0, 0, player.viewHeight), curSector, dir, invoker.max_range, 0);
			if(aim_tracer.hit_wall){
				invoker.swipe_hit_wall = true;
				if(hit_wall_sound) hit_flags |= 4;
			}
		}
		// Play appropriate hit sounds
		if(hit_flags & 1) A_StartSound(hit_flesh_sound);
		if(hit_flags & 2) A_StartSound(hit_metal_sound);
		if(hit_flags & 4) A_StartSound(hit_wall_sound);
	}

	/* Miscellaneous */
	bool uses_self;
	property UsesSelf : uses_self;

	action state UseSelf(StateLabel st = "Ready")
	{
		let ddih = DD_InventoryHolder(findInventory("DD_InventoryHolder"));
		for(let i = 0; i < ddih.items.size(); ++i)
			if(ddih.items[i].item is invoker.getClassName()){
				--ddih.items[i].amount;
				if(ddih.items[i].amount <= 0){
					ddih.removeItem(ddih.items[i], 1);
					return ResolveState(null);
				}
				return ResolveState(st);
			}
		return ResolveState(st);
	}
}


class DD_AimTracer : LineTracer
{
	Actor source;
	Actor toskip;
	Actor hit_obj;
	bool hit_wall;

	override ETraceStatus traceCallback()
	{
		if(results.hitType == TRACE_HitActor)
		{
			if(results.hitActor && (results.hitActor == source || results.hitActor == toskip))
				return TRACE_Skip;
			else if(results.hitActor && results.hitActor.bSHOOTABLE)
			{ hit_obj = Actor(results.hitActor); return TRACE_Stop; }
		} else if(results.hitType == TRACE_HitWall && results.tier == TIER_Middle && results.hitLine.flags & Line.ML_TWOSIDED > 0)
			return TRACE_Skip;
		else if(results.hitType == TRACE_HitWall || results.hitType == TRACE_HitFloor || results.hitType == TRACE_HitCeiling)
		{ hit_wall = true; return TRACE_Stop; }
		return TRACE_Skip;
	}
}

class DD_NoPuff : Actor
{ 
	override void BeginPlay()
	{
		destroy();
		return;
	}
}
