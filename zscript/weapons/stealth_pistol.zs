class DDWeapon_StealthPistol : DDWeapon
{
	default
	{
		Tag "Stealth Pistol";
		Inventory.Icon "DXICWP03";
		Inventory.AltHUDIcon "DXICWP04";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_10mm";
		DDWeapon.BaseClipSize 10;

		DDWeapon.MainDamage 29;

		DDWeapon.BaseSpread 16;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 5;

		DDWeapon.Skill "Weapons: Pistol";

		DDWeapon.HasSilencer true;
	}

	states
	{
		Ready:
			DXSK A 0 A_StartSound("DDWeapon_StealthPistol/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXSK BCDEFG 3;
		ReadyIdle:
			DXSL H 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXSL H 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXSL HIJKLMNO 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXSL PQRSTVWY 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXSL CDEFG 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXSK A 0 CheckClipAmmo("DryFire");
			DXSK A 0 A_StartSound("DDWeapon_StealthPistol/fire");
			DXSK HI 2;
			DXSK A 0 { HitscanAttack(); DoRecoil(); }
			DXSK JKL 2;
			Goto ReadyIdle;
		DryFire:
			DXSK A 0 A_StartSound("DDWeapon/dry_fire");
			DXSK A 6;
			Goto ReadyIdle;
		Reload:
			DXSK A 0 A_StartSound("DDWeapon_StealthPistol/reload");
			DXSK MNOPQRST 3;
		ReloadLoop:
			DXSK VWXYZ 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXSL AB 2;
			DXSL A 0 ReloadClip();
			DXSL A 0 A_StartSound("DDWeapon_StealthPistol/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXSM W -1;
			Stop;
	}
}

