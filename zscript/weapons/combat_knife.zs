class DDWeapon_CombatKnife : DDWeapon
{
	default
	{
		Tag "Combat knife";
		Inventory.Icon "DXICWP23";
		Inventory.AltHUDIcon "DXICWP24";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		Inventory.PickupMessage "You found a combat knife";
		
		DDWeapon.IdleStateAmount 2;
		DDWeapon.FireStateAmount 3;

		DDWeapon.MainDamage 20;

		DDWeapon.AccurateRange 96;
		DDWeapon.MaxRange 96;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;
		+Weapon.MELEEWEAPON;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	states
	{
		Ready:
			DXCK A 0 A_StartSound("DDWeapon_CombatKnife/select");
			DXCK BCD 7;
		ReadyIdle:
			DXCK A 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXCL LMNO 5 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXCL PQRSTUVW 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXCL GHIJK 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXCK A 0 A_StartSound("DDWeapon_CombatKnife/fire");
			DXCK A 0 PlayFireAnim();
		Fire1:
			DXCK EFG 2;
			DXCK H 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_CombatKnife/hit_flesh", "DDWeapon_CombatKnife/hit_metal", "DDWeapon_CombatKnife/hit_wall", FLAG_DONTPUFF);
			DXCK IJKL 2;
			DXCK A 8;
			Goto ReadyIdle;
		Fire2:
			DXCK MNOPQ 1;
			DXCK R 1 HitscanAttack(-1, -1, -1, "", "DDWeapon_CombatKnife/hit_flesh", "DDWeapon_CombatKnife/hit_metal", "DDWeapon_CombatKnife/hit_wall", FLAG_DONTPUFF);
			DXCK STUVWX 1;
			DXCK A 8;
			Goto ReadyIdle;
		Fire3:
			DXCK YZ 2;
			DXCL A 2;
			DXCL B 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_CombatKnife/hit_flesh", "DDWeapon_CombatKnife/hit_metal", "DDWeapon_CombatKnife/hit_wall", FLAG_DONTPUFF);
			DXCL CDEF 2;
			DXCK A 8;
			Goto ReadyIdle;

		Spawn:
			DXCL X -1;
			Stop;
	}
}
