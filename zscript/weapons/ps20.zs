class DDWeapon_PS20 : DDWeapon
{
	default
	{
		Tag "PS20";
		Inventory.Icon "DXICWP07";
		Inventory.AltHUDIcon "DXICWP08";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.MainDamage 300;	

		DDWeapon.BaseSpread 12;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 0;
		DDWeapon.DenyUpgrades true;
		DDWeapon.UsesSelf true;

		DDWeapon.Skill "Weapons: Pistol";
	}

	states
	{
		Ready:
			DXPS A 0 A_StartSound("DDWeapon_PS20/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXPS BCDEFG 2;
		ReadyIdle:
			DXPS A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXPS A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXPT JKLMNO 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXPT PQRSTV 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXPT EFGHI 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXPS A 0 A_StartSound("DDWeapon_PS20/fire");
			DXPS HI 2;
			DXPS A 0 { ProjectileAttack("DDProjectile_PlasmaBolt", GetMainDamage()); DoRecoil(); }
			DXPS JKLMNOPQRSTUVWXYZ 2;
			DXPT ABCD 2;
			DXPT A 0 UseSelf();
			TNT0 A 0 A_Lower(999);
			Stop;

		Spawn:
			DXPT W -1;
			Stop;
	}
}

