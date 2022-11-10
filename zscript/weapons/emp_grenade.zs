class DDWeapon_EMPGrenade : DDWeapon
{
	default
	{
		Tag "EMP grenade";
		Inventory.Icon "DXICWP37";
		Inventory.AltHUDIcon "DXICWP38";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.MainDamage 1000;

		DDWeapon.BaseSpread 12;

		DDWeapon.Recoil 0;
		DDWeapon.DenyUpgrades true;
		DDWeapon.UsesSelf true;

		DDWeapon.Skill "Weapons: Demolition";
	}

	states
	{
		Ready:
			DXEG A 0 A_StartSound("DDWeapon_EMPGrenade/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXEG VWXYZ 4;
			DXEH ABC 4;
		ReadyIdle:
			DXEG ABCDEFGHIJKLMNOPQRSTU 1 { A_WeaponReady(); State s = TryPlayIdleAnim(); if(s) return s; return HandlePlaceAnim(); }
			Loop;
		Idle1:
			DXEI KLMNOPQR 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;
		Idle2:
			DXEI STUVWXYZ 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;

		Deselect:
			DXEH LMNOPQRS 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXEG A 0 HandlePlaceAnim("PlaceFire");
			DXEG A 0 A_StartSound("DDWeapon_EMPGrenade/fire");
			DXEH DEF 3;
			DXEH G 3 ProjectileAttack("DDProjectile_EMPGrenade", GetMainDamage());
			DXEH HIJK 3;
			DXEG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;
		Place:
			DXEH TUVWXY 3;
		PlaceIdle:
			DXEH Y 1 { A_WeaponReady(); return HandlePlaceAnim(null, "PlaceEnd"); }
			Loop;
		PlaceEnd:
			DXEH Z 3;
			DXEI ABCDE 3;
			Goto ReadyIdle;
		PlaceFire:
			DXEI FG 5;
			DXEI H 5 { PlaceProjectile("DDProjectile_PlacedEMPGrenade", GetMainDamage()); A_StartSound("DDThrowableProjectile/bounce"); }
			DXEI IJ 5;
			DXEG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;

		Spawn:
			DXEJ A -1;
			Stop;
	}
}

