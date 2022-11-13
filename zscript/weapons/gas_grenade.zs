class DDWeapon_GasGrenade : DDWeapon
{
	default
	{
		Tag "Gas grenade";
		Inventory.Icon "DXICWP35";
		Inventory.AltHUDIcon "DXICWP36";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

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
			DXGG A 0 A_StartSound("DDWeapon_GasGrenade/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXGG BCDEFGHIJKLM 2;
		ReadyIdle:
			DXGG A 1 A_WeaponReady();
			DXGG A 0 TryPlayIdleAnim();
			DXGG A 0 HandlePlaceAnim();
			Loop;
		Idle1:
			DXGH YZ 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			DXGI ABCDEF 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;
		Idle2:
			DXGI GHIJKLMN 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;

		Deselect:
			DXGG XYZ 3;
			DXGH ABCDEF 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXGG A 0 HandlePlaceAnim("PlaceFire");
			DXGG A 0 A_StartSound("DDWeapon_GasGrenade/fire");
			DXGG NOPQR 3;
			DXGG S 3 ProjectileAttack("DDProjectile_GasGrenade", GetMainDamage());
			DXGG TUVW 3;
			DXGG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;
		Place:
			DXGH GHIJKL 3;
		PlaceIdle:
			DXGH L 1 { A_WeaponReady(); return HandlePlaceAnim(null, "PlaceEnd"); }
			Loop;
		PlaceEnd:
			DXGH MNOPQR 3;
			Goto ReadyIdle;
		PlaceFire:
			DXGH ST 5;
			DXGH U 5 { PlaceProjectile("DDProjectile_PlacedGasGrenade", GetMainDamage()); A_StartSound("DDThrowableProjectile/bounce"); }
			DXGH VWX 5;
			DXGG A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;

		Spawn:
			DXGI O -1;
			Stop;
	}
}

