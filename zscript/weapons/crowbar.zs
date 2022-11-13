class DDWeapon_Crowbar : DDWeapon
{
	default
	{
		Tag "Crowbar";
		Inventory.Icon "DXICWP25";
		Inventory.AltHUDIcon "DXICWP26";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		
		DDWeapon.IdleStateAmount 2;
		DDWeapon.FireStateAmount 2;

		DDWeapon.MainDamage 24;

		DDWeapon.AccurateRange 112;
		DDWeapon.MaxRange 112;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;
		+Weapon.MELEEWEAPON;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	states
	{
		Ready:
			DXCB A 0 A_StartSound("DDWeapon_Crowbar/select");
			DXCB BCDEF 5;
		ReadyIdle:
			DXCB A 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXCC MNOPQRSTUV 3 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXCC WXYZ 3 A_WeaponReady();
			DXCD ABCDEF 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXCC GHIJKL 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXCB A 0 A_StartSound("DDWeapon_Crowbar/fire");
			DXCB A 0 PlayFireAnim();
		Fire1:
			DXCB GGHIJKK 1;
			DXCB L 1 HitscanAttack(-1, -1, -1, "", "DDWeapon_Crowbar/hit_flesh", "DDWeapon_Crowbar/hit_metal", "DDWeapon_Crowbar/hit_wall", FLAG_DONTPUFF);
			DXCB MNNOPPQRR 1;
			DXCB A 8;
			Goto ReadyIdle;
		Fire2:
			DXCB SSTUVWW 1;
			DXCB X 1 HitscanAttack(-1, -1, -1, "", "DDWeapon_Crowbar/hit_flesh", "DDWeapon_Crowbar/hit_metal", "DDWeapon_Crowbar/hit_wall", FLAG_DONTPUFF);
			DXCB YYZ 1;
			DXCC ABBCDDEFF 1;
			DXCB A 8;
			Goto ReadyIdle;

		Spawn:
			DXCD G -1;
			Stop;
	}
}
