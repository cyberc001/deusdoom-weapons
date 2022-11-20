class DDWeapon_PlasmaRifle : DDWeapon
{
	default
	{
		Tag "Plasma Rifle";
		Inventory.Icon "DXICWP41";
		Inventory.AltHUDIcon "DXICWP42";
		DDWeapon.DropSound "DDWeapon/weapon_drop_large";
		DDWeapon.IdleStateAmount 2;
		Inventory.PickupMessage "You found a plasma rifle";

		DDWeapon.AmmoType1 "DDAmmo_PlasmaClip";
		DDWeapon.BaseClipSize 12;

		DDWeapon.MainDamage 35;

		DDWeapon.BaseSpread 13;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 7;

		DDWeapon.Skill "Weapons: Heavy";
	}

	override int GetBulletAmount() { return 3; } // for accurate inventory damage display

	states
	{
		Ready:
			DXPR A 0 A_StartSound("DDWeapon_PlasmaRifle/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXPR KLMNOPQR 3;
		ReadyIdle:
			DXPR ABCDEFGHIJ 1 { A_WeaponReady(WRF_ALLOWRELOAD); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXPS YZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXPT ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXPT GHIJKLMN 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXPS ABCDEFGH 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXPR A 0 CheckClipAmmo("DryFire");
			DXPR A 0 A_StartSound("DDWeapon_PlasmaRifle/fire");
			DXPR STUV 2;
			DXPR W 2 Bright { for(uint i = 0; i < 2; ++i) ProjectileAttack("DDProjectile_PlasmaBolt", GetMainDamage(), false);
								ProjectileAttack("DDProjectile_PlasmaBolt", GetMainDamage());
								DoRecoil(); }
			DXPR XYZ 2;
			DXPR A 8;
			Goto ReadyIdle;
		DryFire:
			DXPR A 0 A_StartSound("DDWeapon/dry_fire");
			DXPR BCDEFG 1;
			Goto ReadyIdle;
		Reload:
			DXPS A 0 A_StartSound("DDWeapon_PlasmaRifle/reload");
			DXPS IJKL 3;
		ReloadLoop:
			DXPS MNOPQRSTU 4 AdvanceReloadTimer(4, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXPS VWX 2;
			DXPS X 0 ReloadClip();
			DXPS X 0 A_StartSound("DDWeapon_PlasmaRifle/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXPT O -1;
			Stop;
	}
}

