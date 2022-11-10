class DDWeapon_Baton : DDWeapon
{
	default
	{
		Tag "Baton";
		Inventory.Icon "DXICWP21";
		Inventory.AltHUDIcon "DXICWP22";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		
		DDWeapon.IdleStateAmount 2;
		DDWeapon.FireStateAmount 2;

		DDWeapon.MainDamage 28;

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
			DXBT A 0 A_StartSound("DDWeapon_Baton/select");
			DXBT BCDEFGHIJKLMNO 3;
		ReadyIdle:
			DXBT A 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXBU Z 3 A_WeaponReady();
			DXBV ABCDEFG 3 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXBV HIJKLMNO 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXBU NOPQRSTUVWXY 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXBT A 0 A_StartSound("DDWeapon_Baton/fire");
			DXBT A 0 PlayFireAnim();
		Fire1:
			DXBT PQRST 2;
			DXBT U 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_Baton/hit_flesh", "DDWeapon_Baton/hit_metal", "DDWeapon_Baton/hit_wall");
			DXBT VWXYZ 2;
			DXBU A 2;
			DXBT A 5;
			Goto ReadyIdle;
		Fire2:
			DXBU BCDEF 2;
			DXBU G 2 HitscanAttack(-1, -1, -1, "", "DDWeapon_Baton/hit_flesh", "DDWeapon_Baton/hit_metal", "DDWeapon_Baton/hit_wall");
			DXBU HIJKLM 2;
			DXBT A 5;
			Goto ReadyIdle;

		Spawn:
			DXBV P -1;
			Stop;
	}
}
