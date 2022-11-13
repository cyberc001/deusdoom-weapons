class DDWeapon_DragonsToothSword : DDWeapon
{
	default
	{
		Tag "Dragon's Tooth sword";
		Inventory.Icon "DXICWP19";
		Inventory.AltHUDIcon "DXICWP20";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";

		DDWeapon.IdleStateAmount 1;
		DDWeapon.FireStateAmount 2;

		DDWeapon.MainDamage 180;

		DDWeapon.AccurateRange 120;
		DDWeapon.MaxRange 120;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;
		+Weapon.MELEEWEAPON;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	DDLight_DragonsToothSword light;
	bool enable_light;
	override void BeginPlay()
	{
		super.BeginPlay();
		light = DDLight_DragonsToothSword(Actor.Spawn("DDLight_DragonsToothSword"));
		light.target = self;
		enable_light = true;
	}
	override void Tick()
	{
		super.Tick();
		if(owner)
			Warp(owner, 0, 0, 0, 0, WARPF_INTERPOLATE);

		if(!light){
			light = DDLight_DragonsToothSword(Actor.Spawn("DDLight_DragonsToothSword"));
			light.target = self;
		}	
		if(owner)
			light.enabled = (owner.player.ReadyWeapon == self && enable_light);
		else
			light.enabled = enable_light;
	}
	override bool TryPickup(in out Actor toucher)
	{
		enable_light = false;
		return super.TryPickup(toucher);
	}

	states
	{
		Ready:
			DXDU A 0 { invoker.enable_light = false; A_StartSound("DDWeapon_DragonsToothSword/select"); }
			DXDU IJKLMNOPQRST 3;
		ReadyIdle:
			DXDT A 0 { invoker.enable_light = true; }
			DXDT ABCDEFGHIJKLMNOPQRSTUVWXYZ 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			DXDU ABCDEFGH 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXDW FGHIJKLM 3 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXDW NOPQRSTU 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXDV YZ 3;
			DXDV Z 0 { invoker.enable_light = false; }
			DXDW ABCDE 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXDT A 0 A_StartSound("DDWeapon_DragonsToothSword/fire");
			DXDT A 0 PlayFireAnim();
			Goto ReadyIdle;
		Fire1:
			DXDU UVVWYY 1;
			DXDU Z 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_DragonsToothSword/hit_flesh", "DDWeapon_DragonsToothSword/hit_metal", "DDWeapon_DragonsToothSword/hit_wall", FLAG_DONTPUFF);
			DXDV ABBCDEFGGHI 1;
			DXDT ABCDEF 1;
			Goto ReadyIdle;
		Fire2:
			DXDV JKKLMM 1;
			DXDU N 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_DragonsToothSword/hit_flesh", "DDWeapon_DragonsToothSword/hit_metal", "DDWeapon_DragonsToothSword/hit_wall", FLAG_DONTPUFF);
			DXDV OPPQRSTUVVWX 1;
			DXDT ABCDEF 1;
			Goto ReadyIdle;

		Spawn:
			DXDX ABCDEFGHIJKLMNOPQRSTUVWXYZ 1;
			DXDY ABCDEFGH 1;
			Loop;
	}
}

class DDLight_DragonsToothSword : Actor
{
	override void Tick()
	{
		super.Tick();
		if(!target){
			Destroy();
			return;
		}
		Warp(target, 0, 0, 0, 0, WARPF_INTERPOLATE);
	}
	bool enabled;

	states
	{
		Spawn:
			DXLD A 1 { if(!enabled) return ResolveState("NoLight"); return ResolveState(null); }
			Loop;
		NoLight:
			DXND A 1 { if(enabled) return ResolveState("Spawn"); return ResolveState(null); }
			Loop;
	}
}
