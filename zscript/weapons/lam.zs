class DDWeapon_LAM : DDWeapon
{
	default
	{
		Tag "LAM";
		Inventory.Icon "DXICWP33";
		Inventory.AltHUDIcon "DXICWP34";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;
		Inventory.PickupMessage "You found a LAM";

		DDWeapon.MainDamage 300;

		DDWeapon.BaseSpread 6;

		DDWeapon.Recoil 0;
		DDWeapon.DenyUpgrades true;
		DDWeapon.UsesSelf true;

		DDWeapon.Skill "Weapons: Demolition";
	}

	states
	{
		Ready:
			DXLM A 0 A_StartSound("DDWeapon_LAM/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXLM BCDEFGHIJKLM 2;
		ReadyIdle:
			DXLM A 1 A_WeaponReady();
			DXLM A 0 TryPlayIdleAnim();
			DXLM A 0 HandlePlaceAnim();
			Loop;
		Idle1:
			DXLN RSTUVWXY 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;
		Idle2:
			DXLN Z 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			DXLO ABCDEF 3 { A_WeaponReady(); return HandlePlaceAnim(); }
			Goto ReadyIdle;

		Deselect:
			DXLM WXYZ 3;
			DXLN A 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXLM A 0 HandlePlaceAnim("PlaceFire");
			DXLM A 0 A_StartSound("DDWeapon_LAM/fire");
			DXLM NOPQR 3;
			DXLM S 3 ProjectileAttack("DDProjectile_LAM", GetMainDamage());
			DXLM TUV 3;
			DXPS A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;
		Place:
			DXLN BCDEF 3;
		PlaceIdle:
			DXLN F 1 { A_WeaponReady(); return HandlePlaceAnim(null, "PlaceEnd"); }
			Loop;
		PlaceEnd:
			DXLN GHIJK 3;
			Goto ReadyIdle;
		PlaceFire:
			DXLN LM 5;
			DXLN N 5 { PlaceProjectile("DDProjectile_PlacedLAM", GetMainDamage()); A_StartSound("DDThrowableProjectile/bounce"); }
			DXLN OPQ 5;
			DXPS A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;
			Goto ReadyIdle;

		Spawn:
			DXLO H -1;
			Stop;
	}
}

