class DDWeapon_ScrambleGrenade : DDWeapon
{
	default
	{
		Tag "Scramble grenade";
		Inventory.Icon "DXICWP39";
		Inventory.AltHUDIcon "DXICWP40";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;
		Inventory.PickupMessage "You found a scramble grenade";

		DDWeapon.MainDamage 1000;

		DDWeapon.BaseSpread 6;

		DDWeapon.Recoil 0;
		DDWeapon.DenyUpgrades true;
		DDWeapon.UsesSelf true;

		DDWeapon.Skill "Weapons: Demolition";
	}

	states
	{
		Ready:
			DXSG A 0 A_StartSound("DDWeapon_ScrambleGrenade/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.1);
			DXSG PQRSTUVW 4;
		ReadyIdle:
			DXSG ABCDEFGHIJKLMNO 1 { A_WeaponReady(); State s = TryPlayIdleAnim(); if(s) return s; return HandlePlaceAnim(); }
			Loop;
		Idle1:
			DXSH Z 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			DXSI ABCDEFG 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;
		Idle2:
			DXSI HIJKLMNO 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;

		Deselect:
			DXSH FGHIJKLM 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXSG A 0 HandlePlaceAnim("PlaceFire");
			DXSG A 0 A_StartSound("DDWeapon_ScrambleGrenade/fire");
			DXSG XYZ 3;
			DXSH A 3 ProjectileAttack("DDProjectile_ScrambleGrenade", GetMainDamage());
			DXSH BCDE 3;
			DXSG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;
		Place:
			DXSH NOP 4;
		PlaceIdle:
			DXSH P 1 { A_WeaponReady(); return HandlePlaceAnim(null, "PlaceEnd"); }
			Loop;
		PlaceEnd:
			DXSH QRS 3;
			Goto ReadyIdle;
		PlaceFire:
			DXSH TU 5;
			DXSH V 5 { PlaceProjectile("DDProjectile_PlacedScrambleGrenade", GetMainDamage()); A_StartSound("DDThrowableProjectile/bounce"); }
			DXSH WXY 5;
			DXSG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;

		Spawn:
			DXSI P -1;
			Stop;
	}
}

