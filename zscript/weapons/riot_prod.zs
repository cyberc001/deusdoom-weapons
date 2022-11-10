class DDWeapon_RiotProd : DDWeapon
{
	default
	{
		Tag "Riot Prod";
		Inventory.Icon "DXICWP17";
		Inventory.AltHUDIcon "DXICWP18";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_ProdCharger";
		DDWeapon.BaseClipSize 4;

		DDWeapon.MainDamage 30;

		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.AccurateRange 112;
		DDWeapon.MaxRange 112;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	states
	{
		Ready:
			DXRP A 0 A_StartSound("DDWeapon_RiotProd/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXRP VWXYZ 3;
			DXRR ABCDEFGHIJ 3;
		ReadyIdle:
			DXRP ABCEDFGHIJKLMNOPQRSTU 3 { A_WeaponReady(WRF_ALLOWRELOAD); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXRS QRSTUVWX 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXRS YZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXRT ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXRR QRSTUVWX 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXRP A 0 CheckClipAmmo("DryFire");
			DXRR KLM 3;
		Hold:
			DXRR N 0 CheckClipAmmo("DryFire");
			DXRR N 0 A_StartSound("DDWeapon_RiotProd/fire");
			DXRR N 5;
			DXRR N 0 HitscanAttack(-1, -1, -1, "DDPowerup_Stun");
			DXRR NNNNNN 5; // makes gzdoom engine not interpolate this frame over 45 ticks
			DXRR N 5 A_ReFire();
			DXRP OP 4;
			Goto ReadyIdle;
		DryFire:
			DXRP A 0 A_StartSound("DDWeapon/dry_fire");
			DXRP AB 3;
			Goto ReadyIdle;
		Reload:
			DXRR A 0 A_StartSound("DDWeapon_RiotProd/reload");
			DXRR YZ 3;
			DXRS A 3;
		ReloadLoop:
			DXRS BCDEFGHIJKLM 3 AdvanceReloadTimer(3, "ReloadEnd");
			Loop;
		ReloadEnd:
			DXRS NOP 2;
			DXRS P 0 ReloadClip();
			DXRS P 0 A_StartSound("DDWeapon_RiotProd/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXRT G -1;
			Stop;
	}
}
