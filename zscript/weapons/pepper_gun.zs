class DDWeapon_PepperGun : DDWeapon
{
	default
	{
		Tag "Pepper gun";
		Inventory.Icon "DXICWP31";
		Inventory.AltHUDIcon "DXICWP32";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";

		DDWeapon.AmmoType1 "DDAmmo_PepperCartridge";
		DDWeapon.BaseClipSize 100;
		
		DDWeapon.IdleStateAmount 2;

		DDWeapon.MainDamage 0;
		DDWeapon.BaseReloadTime 35*4;

		DDWeapon.AccurateRange 192;
		DDWeapon.MaxRange 192;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	override int GetBonusClipPerUpgrade() { return 15; }
	override int GetPenetrationAmount() { return 8; }

	action void DoPepperMist(double ang_off = 0, double pitch_off = 0)
	{
		vector3 sppos = pos;
		vector3 dir = (Actor.AngleToVector(angle - 13 + ang_off, cos(pitch + 8 + pitch_off)), -sin(pitch + 8 + pitch_off));
		sppos += dir * 20;
		sppos.z += player.ViewZ - pos.z - 5 + sin(pitch) * 10;
		let eff = DDanimatedEffect_TearGas(Spawn("DDAnimatedEffect_TearGas", sppos));
		eff.warp_off = sppos - pos;
		eff.dir = dir;
		eff.target = self;
	}

	states
	{
		Ready:
			DXPG A 0 A_StartSound("DDWeapon_PepperGun/select");
			DXPG BCDEFG 3;
		ReadyIdle:
			DXPG A 1 { A_WeaponReady(WRF_ALLOWRELOAD); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXPH IJKLMNOP 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXPH QRSTUVWX 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXPH CDEFGH 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXPG A 0 CheckClipAmmo("DryFire");
			DXPG A 0 A_StartSound("DDWeapon_PepperGun/fire", CHAN_WEAPON, CHANF_DEFAULT, 0.7);
			DXPG H 2 { DoPepperMist(); HitscanAttack(-1, -1, -1, "DDPowerup_PepperStun", "", "", "", FLAG_DONTPUFF); CheckClipAmmo("DryFire"); }
			DXPG I 2 DoPepperMist(-2); 
			DXPG J 2 { DoPepperMist(-4); HitscanAttack(-1, -1, -1, "DDPowerup_PepperStun", "", "", "", FLAG_DONTPUFF); CheckClipAmmo("DryFire"); }
			DXPG K 2 DoPepperMist(-6); 
			DXPG L 2 { DoPepperMist(-6); HitscanAttack(-1, -1, -1, "DDPowerup_PepperStun", "", "", "", FLAG_DONTPUFF); CheckClipAmmo("DryFire"); }
			DXPG M 2 DoPepperMist(-4); 
			DXPG N 2 { DoPepperMist(-2); HitscanAttack(-1, -1, -1, "DDPowerup_PepperStun", "", "", "", FLAG_DONTPUFF); CheckClipAmmo("DryFire"); }
			DXPG O 2 DoPepperMist(); 
			Goto ReadyIdle;
		DryFire:
			DXPG A 0 A_StartSound("DDWeapon/dry_fire");
			DXPG A 6;
			Goto ReadyIdle;

		Reload:
			DXPG A 0 A_StartSound("DDWeapon_PepperGun/reload");
			DXPG PQRS 3;
		ReloadLoop:
			DXPG TUVWXY 3 AdvanceReloadTimer(3, "ReloadEnd");
			Loop;
		ReloadEnd:
			DXPG Z 3;
			DXPH AB 3;
			DXPH B 0 ReloadClip();
			DXPH B 0 A_StartSound("DDWeapon_PepperGun/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXPH Y -1;
			Stop;
	}
}
