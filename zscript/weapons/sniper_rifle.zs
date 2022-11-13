class DDWeapon_SniperRifle : DDWeapon
{
	default
	{
		Tag "Sniper Rifle";
		Inventory.Icon "DXICWP15";
		Inventory.AltHUDIcon "DXICWP16";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_30_06";
		DDWeapon.BaseClipSize 6;

		DDWeapon.MainDamage 100;

		DDWeapon.BaseSpread 9;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 12;

		DDWeapon.AccurateRange 4096;
		DDWeapon.MaxRange 6198;

		DDWeapon.HasScope true;
		DDWeapon.ScopeFOV 10 * 2.5;

		DDWeapon.CanInstallSilencer true;

		DDWeapon.Skill "Weapons: Rifle";
	}

	states
	{
		Ready:
			DXSR A 0 A_StartSound("DDWeapon_SniperRifle/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXSR BCDEFGHIJK 3;
		ReadyIdle:
			DXSR A 1 A_WeaponReady(WRF_ALLOWRELOAD | WRF_ALLOWZOOM);
			DXSR A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXSS KLMNOPQRST 3 A_WeaponReady(WRF_ALLOWRELOAD | WRF_ALLOWZOOM);
			Goto ReadyIdle;
		Idle2:
			DXSS UVWXYZ 3 A_WeaponReady(WRF_ALLOWRELOAD | WRF_ALLOWZOOM);
			DXST ABCD 3 A_WeaponReady(WRF_ALLOWRELOAD | WRF_ALLOWZOOM);
			Goto ReadyIdle;

		Deselect:
			DXSS A 0 LowerScope();
			DXSS IJ 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXSR A 0 CheckClipAmmo("DryFire");
			DXSR A 0 A_StartSound("DDWeapon_SniperRifle/fire", CHAN_WEAPON, CHANF_DEFAULT, invoker.has_silencer ? 0.3 : 1);
			DXSR L 2;
			DXSR M 2 { HitscanAttack(); DoRecoil(); }
			DXSR NOPQ 2;
			DXSR Q 12;
			Goto ReadyIdle;
		DryFire:
			DXSR A 0 A_StartSound("DDWeapon/dry_fire");
			DXSR A 6;
			Goto ReadyIdle;
		Reload:
			DXSR A 0 A_StartSound("DDWeapon_SniperRifle/reload");
			DXSR A 0 LowerScope();
			DXSR RSTUVWXY 3;
		ReloadLoop:
			DXSR Z 6 AdvanceReloadTimer(6, "ReloadEnd");
			DXSS ABCD 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXSS EFGH 3;
			DXSS H 0 ReloadClip();
			DXSS H 0 A_StartSound("DDWeapon_SniperRifle/reload_end");
			Goto ReadyIdle;

		Zoom:
			DXST FGH 3;
			DXST H 0 ToggleScope();
			Goto ReadyIdle;

		Spawn:
			DXST E -1;
			Stop;
	}
}
