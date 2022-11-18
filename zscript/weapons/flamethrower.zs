class DDWeapon_Flamethrower : DDWeapon
{
	default
	{
		Tag "Flamethrower";
		Inventory.Icon "DXICWP45";
		Inventory.AltHUDIcon "DXICWP46";
		DDWeapon.DropSound "DDWeapon/weapon_drop_large";
		DDWeapon.IdleStateAmount 2;
		Inventory.PickupMessage "You found a flamethrower";

		DDWeapon.AmmoType1 "DDAmmo_Napalm";
		DDWeapon.BaseClipSize 100;

		DDWeapon.MainDamage 5;

		DDWeapon.BaseSpread 18;
		DDWeapon.BaseReloadTime 35*5+17;

		DDWeapon.Skill "Weapons: Heavy";
	}

	int flame_count;
	override int GetBonusClipPerUpgrade() { return 10; }

	states
	{
		Ready:
			DXFT A 0 A_StartSound("DDWeapon_Flamethrower/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXFT XYZ 5;
			DXFU ABCDE 5;
		ReadyIdle:
			DXFT ABCDEFGHIKLMNOPQRSTUVW 1 { A_WeaponReady(WRF_ALLOWRELOAD); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXFV HIJKLMNO 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXFV PQRSTUVW 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXFV BCDEF 4;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXFT A 0 CheckClipAmmo("DryFire");
			DXFU FG 2;
		Hold:
			DXFU G 0 CheckClipAmmo("DryFire");
			DXFU G 0 A_StartSound("DDWeapon_Flamethrower/fire");
			DXFU G 0 { invoker.flame_count = 0; }
			DXFU HIJKLKJI 2 {
								if(invoker.flame_count != 1 && invoker.flame_count != 4 && invoker.flame_count != 6)
									ProjectileAttack("DDAnimatedProjectile_Fireball", GetMainDamage(), true, (20, 0, -15));
								++invoker.flame_count;
							}
			DXFU I 0 A_ReFire();
			Goto ReadyIdle;
		DryFire:
			DXFT A 0 A_StartSound("DDWeapon/dry_fire");
			DXFT ABCDE 1;
			Goto ReadyIdle;
		Reload:
			DXFT A 0 A_StartSound("DDWeapon_Flamethrower/reload");
			DXFU NOP 3;
		ReloadLoop:
			DXFU QRSTUVW 6 AdvanceReloadTimer(6, "ReloadEnd");
			DXFU Q 0;
		Loop;
		ReloadEnd:
			DXFU XYZ 3;
			DXFV A 3;
			DXFV A 0 ReloadClip();
			DXFV A 0 A_StartSound("DDWeapon_Flamethrower/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXFV X -1;
			Stop;
	}
}

