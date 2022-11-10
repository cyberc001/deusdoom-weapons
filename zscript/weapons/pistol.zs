class DDWeapon_Pistol : DDWeapon
{
	default
	{
		Tag "Pistol";
		Inventory.Icon "DXICWP01";
		Inventory.AltHUDIcon "DXICWP02";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_10mm";
		DDWeapon.BaseClipSize 6;

		DDWeapon.MainDamage 32;

		DDWeapon.BaseSpread 14;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 12;

		DDWeapon.Skill "Weapons: Pistol";
	}

	states
	{
		Ready:
			DXGK A 0 A_StartSound("DDWeapon_Pistol/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXGK BCDEFGHIJKLMNOP 2;
		ReadyIdle:
			DXGK A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXGK A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXGL Z 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXGM ABCDEFG 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXGM KLMNOPQRSTUV 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXGK QRS 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXGK A 0 CheckClipAmmo("DryFire");
			DXGK A 0 A_StartSound("DDWeapon_Pistol/fire");
			DXGK TU 2;
			DXGK A 0 { HitscanAttack(); DoRecoil(); }
			DXGK VWXYZ 2;
			DXGL A 2;
			Goto ReadyIdle;
		DryFire:
			DXGK A 0 A_StartSound("DDWeapon/dry_fire");
			DXGK T 6;
			Goto ReadyIdle;
		Reload:
			DXGL A 0 A_StartSound("DDWeapon_Pistol/reload");
			DXGL BCDEFGHIJKL 1;
			DXGL MNOPQ 2;
		ReloadLoop:
			DXGL RSTUV 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXGL WXY 2;
			DXGL A 0 ReloadClip();
			Goto ReadyIdle;

		Spawn:
			DXGM W -1;
			Stop;
	}
}

