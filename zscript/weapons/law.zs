class DDWeapon_LAW : DDWeapon
{
	default
	{
		Tag "LAW";
		Inventory.Icon "DXICWP43";
		Inventory.AltHUDIcon "DXICWP44";
		DDWeapon.DropSound "DDWeapon/weapon_drop_large";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.MainDamage 2500;

		DDWeapon.BaseSpread 12;

		DDWeapon.Recoil 30;
		DDWeapon.DenyUpgrades true;
		DDWeapon.UsesSelf true;

		DDWeapon.Skill "Weapons: Heavy";
	}

	states
	{
		Ready:
			DXLW A 0 A_StartSound("DDWeapon_LAW/select"); 
			DXLW BCDEFGHIJK 4;
		ReadyIdle:
			DXLW A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXLW A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXLY BCDEFGHIJK 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXLY LMNOPQRSTU 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXLX RSTUVWXYZ 4;
			DXLY A 4;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXLW A 0 A_StartSound("DDWeapon_LAW/fire");
			DXLW LMN 1;
			DXLW A 0 { ProjectileAttack("DDProjectile_RocketLAW", GetMainDamage()); DoRecoil(); }
			DXLW OPQRSTUVWXYZ 1;
			DXLX ABCDEFGHIJKLMNOPQ 1;
			DXLX Q 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;

		Spawn:
			DXPT W -1;
			Stop;
	}
}

