class DDWeaponUpgrade : DDItem
{
	default
	{
		Inventory.MaxAmount 16;
		Height 15;
		Radius 15;
	}

	override bool TryPickup(in out Actor toucher)
	{
		return toucher && toucher is "DDWeapon";
	}

	override bool isApplicable(Inventory another)
	{
		return another is "DDWeapon" && !DDWeapon(another).deny_upgrades;
	}
}

class DDWeaponUpgrade_Accuracy : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO03";
		Tag "Weapon Modification (Accuracy)";
		Inventory.PickupMessage "You found an accuracy mod";
	}

	states
	{
		Spawn:
			DXUP A -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && DDWeapon(another).getBaseSpread() > 0;
	}

	override void applyTo(Inventory another)
	{
		let wep = DDWeapon(another);
		wep.base_spread -= 3;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}

class DDWeaponUpgrade_Clip : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO04";
		Tag "Weapon Modification (Clip)";
		Inventory.PickupMessage "You found a clip mod";
	}

	states
	{
		Spawn:
			DXUP B -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && DDWeapon(another).bonus_clip < DDWeapon(another).max_bonus_clip;

	}

	override void applyTo(Inventory another)
	{
		++DDWeapon(another).bonus_clip;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}

class DDWeaponUpgrade_Recoil : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO07";
		Tag "Weapon Modification (Recoil)";
		Inventory.PickupMessage "You found a recoil mod";
	}

	states
	{
		Spawn:
			DXUP C -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && DDWeapon(another).recoil > 0;
	}

	override void applyTo(Inventory another)
	{
		DDWeapon(another).recoil -= 5;
		if(DDWeapon(another).recoil < 0) DDWeapon(another).recoil = 0;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}

class DDWeaponUpgrade_Reload : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO08";
		Tag "Weapon Modification (Reload)";
		Inventory.PickupMessage "You found a reload mod";
	}

	states
	{
		Spawn:
			DXUP D -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && DDWeapon(another).getTotalReloadTime() > 0;
	}

	override void applyTo(Inventory another)
	{
		DDWeapon(another).reload_time_decrease += DDWeapon(another).base_reload_time * 0.2;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}

class DDWeaponUpgrade_Silencer : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO10";
		Tag "Weapon Modification (Silencer)";
		Inventory.PickupMessage "You found a silencer mod";
	}

	states
	{
		Spawn:
			DXUP E -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && !DDWeapon(another).has_silencer && DDWeapon(another).can_install_silencer;
	}

	override void applyTo(Inventory another)
	{
		DDWeapon(another).has_silencer = true;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}

class DDWeaponUpgrade_Laser : DDWeaponUpgrade
{
	default
	{
		Inventory.Icon "DXICO05";
		Tag "Weapon Modification (Laser)";
		Inventory.PickupMessage "You found an laser mod";
	}

	states
	{
		Spawn:
			DXUP F -1;
			Stop;
	}

	override bool isApplicable(Inventory another)
	{
		return super.isApplicable(another) && !DDWeapon(another).has_laser;
	}

	override void applyTo(Inventory another)
	{
		DDWeapon(another).has_laser = true;
		owner.A_StartSound("DDWeaponUpgrade/apply", CHAN_AUTO, CHANF_LOCAL);
	}
}
