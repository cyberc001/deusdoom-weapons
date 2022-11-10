#include "zscript/projectiles/throwable.zs"
#include "zscript/projectiles/placeable.zs"

#include "zscript/projectiles/dart.zs"
#include "zscript/projectiles/plasma_bolt.zs"
#include "zscript/projectiles/he20mm.zs"
#include "zscript/projectiles/throwing_knife.zs"

#include "zscript/projectiles/lam.zs"
#include "zscript/projectiles/gas_grenade.zs"
#include "zscript/projectiles/emp_grenade.zs"
#include "zscript/projectiles/scramble_grenade.zs"

#include "zscript/projectiles/rocket_law.zs"
#include "zscript/projectiles/rocket_gepgun.zs"
#include "zscript/projectiles/wprocket_gepgun.zs"

#include "zscript/projectiles/fireball.zs"

class DDProjectile : Actor
{
	default
	{
		Radius 5;
		Height 5;

		Projectile;

		DDProjectile.PickupAmount 1;
		DDProjectile.GravityZAccel 0;
		DDProjectile.ExplosionTimer -1;
	}

	states
	{
		Death:
			#### # 1 { if(!stay_on_wall_hit) return ResolveState("DeathStop"); return ResolveState("DeathLoopStart"); }
		DeathLoopStart:
			#### # 0 { self.in_wall = true; if(self.can_be_picked_up) A_ChangeFlag("NOBLOCKMAP", false); OnDeathLoop(); }
		DeathLoop:
			#### # 1; 
			Loop;
		XDeath:
		Crash:
			#### # 0 { if(stay_on_actor_hit) return ResolveState("DeathLoop"); return ResolveState(null); }
		DeathStop:
			#### # 1 { OnDeathStop(); }
			Stop;
	}

	double grav_zacc;
	property GravityZAccel: grav_zacc;
	bool fall_flat;
	property FallFlat: fall_flat; // fall (change pitch) after losing all momentum

	action State CheckFallFlat(StateLabel ffl_state = "FallFlat")
	{
		if(sqrt(vel.x**2+vel.y**2) <= 4)
			return ResolveState(ffl_state);
		return ResolveState(null);
	}

	const pitch_inc = 8;
	double target_pitch;
	bool desire_pitch;

	int explosion_timer;
	property ExplosionTimer: explosion_timer;

	virtual void ExplodeOnTimer(){}

	override void Tick()
	{
		super.Tick();
		A_ChangeVelocity(0, 0, -grav_zacc);

		if(sqrt(vel.x**2 + vel.y**2) <= 8 && fall_flat){
			fall_flat = false;
			target_pitch = 90;
			desire_pitch = true;
		}
		if(desire_pitch && pitch < target_pitch)
			pitch += pitch_inc;
		else if(pitch >= target_pitch)
			desire_pitch = false;

		if(explosion_timer > 0)
			--explosion_timer;
		else if(explosion_timer == 0){
			--explosion_timer;
			ExplodeOnTimer();
		}
	}


	virtual void OnDeathStop(){}
	virtual void OnDeathLoop(){}

	int _damage;

	virtual void DamageVictim(Actor victim)
	{
		victim.DamageMobj(self, target, _damage, "None");
	}

	void DoExplosion(int _damage, int _radius)
	{ // Detailed mechanics: https://deusex.fandom.com/wiki/Explosions_(DX)
		double radius = _radius;
		double damage = _damage * 0.4;
		BlockThingsIterator itb = BlockThingsIterator.Create(self, radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if(victim == self || !CheckSight(victim) || (!victim.bISMONSTER && !victim.player))
				continue;

			for(int i = 1; i <= 5; ++i){
				double rad = radius * i / 5;
				double dist = (Distance3D(victim) - victim.radius) / rad;
				dist /= 1.5; // A random coefficient though, because hitting the "sweet spot" is easier in Doom due to collision checking in "cylinders", not actual spheres.
				dist = dist > 1 ? 1 : dist < 0 ? 0 : dist;
				victim.DamageMobj(self, target, damage * (1 - dist), "None");
			}
		}
	}

	bool stay_on_wall_hit;
	property StayOnWallHit : stay_on_wall_hit;
	bool stay_on_actor_hit;
	property StayOnActorHit: stay_on_actor_hit;

	override int SpecialMissileHit(Actor victim)
	{
		int ret = super.SpecialMissileHit(victim);
		if(ret == -1 && victim != target)
			DamageVictim(victim);
		return ret;
	}
	
	bool can_be_picked_up;
	property CanBePickedUp : can_be_picked_up;
	Name pickup_class;
	property PickUpClass : pickup_class;
	int pickup_amt;
	property PickupAmount : pickup_amt;
	bool in_wall;

	override bool Used(Actor user)
	{
		if(can_be_picked_up && in_wall){
			let pickup_spawned = Actor.Spawn(pickup_class);

			if(pickup_spawned is "DDItem" || pickup_spawned is "DDWeapon"){
				let ddih = DD_InventoryHolder(user.FindInventory("DD_InventoryHolder"));
				if(pickup_spawned is "DDWeapon" && DDWeapon(pickup_spawned).toss_one)
					Inventory(pickup_spawned).amount = 1;
				ddih.addItem(Inventory(pickup_spawned));
			}
			else{
				user.A_GiveInventory(pickup_class, pickup_amt);
				pickup_spawned.Destroy();
			}
			Destroy();
			return true;
		}
		return false;
	}

	/* Miscellaneous */
	void SpawnSpreadActors(class<Actor> cls, class<Actor> cls2 = null, uint amt = 8, double spread_x = 80, double spread_y = 80)
	{
		for(uint i = 0; i < amt; ++i){
			vector3 _pos = (pos.x + frandom(-spread_x, spread_X), pos.y + frandom(-spread_y, spread_y), pos.z);
			Spawn(cls, _pos);
			if(cls2)
				Spawn(cls2, _pos);
		}

	}
}
