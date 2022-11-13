class DDWeapon_Sword : DDWeapon
{
	default
	{
		Tag "Sword";
		Inventory.Icon "DXICWP27";
		Inventory.AltHUDIcon "DXICWP28";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		
		DDWeapon.IdleStateAmount 2;
		DDWeapon.FireStateAmount 2;

		DDWeapon.MainDamage 50;

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
			DXSW A 0 A_StartSound("DDWeapon_Sword/select");
			DXSW BCDEFGH 5;
		ReadyIdle:
			DXSW A 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXSX OPQRSTUVW 3 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXSX XYZ 3 A_WeaponReady();
			DXSY ABCDEF 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXSX GHIJKLMN 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXSW A 0 A_StartSound("DDWeapon_Sword/fire");
			DXSW A 0 PlayFireAnim();
		Fire1:
			DXSW IIJKLMM 1;
			DXSW N 1 HitscanAttack(-1, -1, -1, "", "DDWeapon_Sword/hit_flesh", "DDWeapon_Sword/hit_metal", "DDWeapon_Sword/hit_wall", FLAG_DONTPUFF);
			DXSW OPPQRRSTT 1;
			DXSW A 8;
			Goto ReadyIdle;
		Fire2:
			DXSW UUVWXYY 1;
			DXSW Z 1 HitscanAttack(-1, -1, -1, "", "DDWeapon_Sword/hit_flesh", "DDWeapon_Sword/hit_metal", "DDWeapon_Sword/hit_wall", FLAG_DONTPUFF);
			DXSX ABBCDDEFF 1;
			DXSW A 8;
			Goto ReadyIdle;

		Spawn:
			DXSY G -1;
			Stop;
	}
}
