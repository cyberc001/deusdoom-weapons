/* Ammo */

class DDSpawner_Clip : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Clip";
		DDSpawner.SpawnChance 0.6;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDAmmo_10mm";
		actors.push(cls); chances.push(9); flags.push(0);
		cls = "DDAmmo_Darts";
		actors.push(cls); chances.push(8); flags.push(0);
		cls = "DDAmmo_TranquilizerDarts";
		actors.push(cls); chances.push(2); flags.push(0);
		cls = "DDAmmo_FlareDarts";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_7_62mm";
		actors.push(cls); chances.push(15); flags.push(0);
		cls = "DDAmmo_30_06";
		actors.push(cls); chances.push(6); flags.push(0);

		cls = "DDWeapon_ThrowingKnives";
		actors.push(cls); chances.push(4); flags.push(0);

		cls = "DDAmmo_PepperCartridge";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_ProdCharger";
		actors.push(cls); chances.push(1); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_BonusPistolAmmo_Small";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_ClipBox : DDSpawner_Clip
{
	default
	{
		DDSpawner.ToReplace "ClipBox";
		DDSpawner.SpawnChance 1.75;
		DDSpawner.ChanceMul 0.5;
	}

	override void BeginPlay()
	{
		class<DDSpawner> sp = "DDSpawner_BonusPistolAmmo_Large";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

class DDSpawner_Shell : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Shell";
		DDSpawner.SpawnChance 1;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDAmmo_12gaBuckshot";
		actors.push(cls); chances.push(11); flags.push(0);
		cls = "DDAmmo_12gaSabot";
		actors.push(cls); chances.push(2); flags.push(0);

		cls = "DDWeapon_ThrowingKnives";
		actors.push(cls); chances.push(1); flags.push(0);

		cls = "DDAmmo_PepperCartridge";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_ProdCharger";
		actors.push(cls); chances.push(1); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_BonusPistolAmmo_Small";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_ShellBox : DDSpawner_Shell
{
	default
	{
		DDSpawner.ToReplace "ShellBox";
		DDSpawner.SpawnChance 3;
		DDSpawner.ChanceMul 0.6;
	}
	override void BeginPlay()
	{
		class<DDSpawner> sp = "DDSpawner_BonusPistolAmmo_Large";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

class DDSpawner_RocketAmmo : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "RocketAmmo";
		DDSpawner.SpawnChance 0.2;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDAmmo_Rockets";
		actors.push(cls); chances.push(13); flags.push(0);
		cls = "DDAmmo_WPRockets";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_HE20mm";
		actors.push(cls); chances.push(5); flags.push(0);

		cls = "DDAmmo_PepperCartridge";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_ProdCharger";
		actors.push(cls); chances.push(1); flags.push(0);
		
		class<DDSpawner> sp = "DDSpawner_Grenades_RocketAmmo";
		spawn_along.push(sp);
		sp = "DDSpawner_BonusPistolAmmo_Small";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_RocketBox : DDSpawner_RocketAmmo
{
	default
	{
		DDSpawner.ToReplace "RocketBox";
		DDSpawner.SpawnChance 1;
		DDSpawner.ChanceMul 0.3;
	}
	override void BeginPlay()
	{
		class<DDSpawner> sp = "DDSpawner_Grenades_RocketBox";
		spawn_along.push(sp);
		sp = "DDSpawner_BonusPistolAmmo_Large";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

// extra spawners for 10mm and darts
class DDSpawner_BonusPistolAmmo_Small : DDSpawner
{
	default
	{
		DDSpawner.SpawnChance 0.15;
		DDSpawner.ChanceMul 0.35;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDAmmo_10mm";
		actors.push(cls); chances.push(10); flags.push(0);
		cls = "DDAmmo_Darts";
		actors.push(cls); chances.push(7); flags.push(0);
		cls = "DDAmmo_TranquilizerDarts";
		actors.push(cls); chances.push(2); flags.push(0);
		cls = "DDAmmo_FlareDarts";
		actors.push(cls); chances.push(1); flags.push(0);

		super.BeginPlay();
	}
}

class DDSpawner_BonusPistolAmmo_Large : DDSpawner_BonusPistolAmmo_Small
{
	default
	{
		DDSpawner.SpawnChance 1;
		DDSpawner.ChanceMul 0.2;
	}
}

class DDSpawner_Grenades_RocketAmmo : DDSpawner
{
	default
	{
		DDSpawner.SpawnChance 0.15;
	}
	override void BeginPlay()
	{
		Class<Actor> cls = "DDWeapon_LAM";
		actors.push(cls); chances.push(9); flags.push(0);
		cls = "DDWeapon_GasGrenade";
		actors.push(cls); chances.push(2); flags.push(0);
		cls = "DDWeapon_PS20";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_EMPGrenade";
		actors.push(cls); chances.push(2); flags.push(0);
		cls = "DDWeapon_ScrambleGrenade";
		actors.push(cls); chances.push(1); flags.push(0);

		super.BeginPlay();
	}
}
class DDSpawner_Grenades_RocketBox : DDSpawner_Grenades_RocketAmmo
{
	default
	{
		DDSpawner.SpawnChance 2;
		DDSpawner.ChanceMul 0.3;
	}
}

class DDSpawner_Cell : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Cell";
		DDSpawner.SpawnChance 0.75;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDAmmo_PlasmaClip";
		actors.push(cls); chances.push(13); flags.push(0);
		cls = "DDAmmo_Napalm";
		actors.push(cls); chances.push(7); flags.push(0);

		cls = "DDAmmo_PepperCartridge";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDAmmo_ProdCharger";
		actors.push(cls); chances.push(1); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_Grenades_Cell";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

class DDSpawner_CellPack : DDSpawner_Cell
{
	default
	{
		DDSpawner.ToReplace "CellPack";
		DDSpawner.SpawnChance 3;
		DDSpawner.ChanceMul 0.5;
	}

	override void BeginPlay()
	{
		class<DDSpawner> sp = "DDSpawner_Grenades_CellPack";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

class DDSpawner_Grenades_Cell : DDSpawner
{
	default
	{
		DDSpawner.SpawnChance 0.15;
	}
	override void BeginPlay()
	{
		Class<Actor> cls = "DDWeapon_PS20";
		actors.push(cls); chances.push(2); flags.push(0);
		cls = "DDWeapon_EMPGrenade";
		actors.push(cls); chances.push(4); flags.push(0);
		cls = "DDWeapon_ScrambleGrenade";
		actors.push(cls); chances.push(2); flags.push(0);

		super.BeginPlay();
	}
}

class DDSpawner_Grenades_CellPack : DDSpawner_Grenades_Cell
{
	default
	{
		DDSpawner.SpawnChance 1.25;
		DDSpawner.ChanceMul 0.35;
	}
}

/* Weapons */
class DDSpawner_Pistol : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Pistol";
	}
	override void BeginPlay()
	{
		Class<Actor> cls = "DDWeapon_Pistol";
		actors.push(cls); chances.push(10); flags.push(0);
		cls = "DDWeapon_StealthPistol";
		actors.push(cls); chances.push(4); flags.push(0);
		cls = "DDWeapon_MiniCrossbow";
		actors.push(cls); chances.push(6); flags.push(0);

		super.BeginPlay();
	}
}

class DDSpawner_Chainsaw : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Chainsaw";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_Baton";
		actors.push(cls); chances.push(7); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_CombatKnife";
		actors.push(cls); chances.push(9); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_Crowbar";
		actors.push(cls); chances.push(6); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_RiotProd";
		actors.push(cls); chances.push(4); flags.push(0);
		cls = "DDWeapon_Sword";
		actors.push(cls); chances.push(2); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_PepperGun";
		actors.push(cls); chances.push(3); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_WeaponUpgrade_PlasmaRifle";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_Shotgun : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Shotgun";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_AssaultShotgun";
		actors.push(cls); chances.push(22); flags.push(0);
		cls = "DDWeapon_SawedOffShotgun";
		actors.push(cls); chances.push(5); flags.push(0);

		cls = "DDWeapon_Pistol";
		actors.push(cls); chances.push(16); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_StealthPistol";
		actors.push(cls); chances.push(12); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_MiniCrossbow";
		actors.push(cls); chances.push(14); flags.push(FLAG_DONTDUP);

		cls = "DDWeapon_Baton";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_CombatKnife";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_Crowbar";
		actors.push(cls); chances.push(2); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_RiotProd";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_Sword";
		actors.push(cls); chances.push(1); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_PepperGun";
		actors.push(cls); chances.push(1); flags.push(0);

		super.BeginPlay();
	}
}
class DDSpawner_SuperShotgun : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "SuperShotgun";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_SawedOffShotgun";
		actors.push(cls); chances.push(18); flags.push(0);
		cls = "DDWeapon_AssaultShotgun";
		actors.push(cls); chances.push(7); flags.push(FLAG_DONTDUP);

		cls = "DDWeapon_Pistol";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_StealthPistol";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_MiniCrossbow";
		actors.push(cls); chances.push(1); flags.push(0);

		cls = "DDWeapon_Baton";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_CombatKnife";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_Crowbar";
		actors.push(cls); chances.push(2); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_RiotProd";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_Sword";
		actors.push(cls); chances.push(1); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_PepperGun";
		actors.push(cls); chances.push(1); flags.push(0);


		super.BeginPlay();
	}
}
class DDSpawner_Chaingun : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "Chaingun";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_AssaultRifle";
		actors.push(cls); chances.push(23); flags.push(0);
		cls = "DDWeapon_SniperRifle";
		actors.push(cls); chances.push(10); flags.push(0);

		cls = "DDWeapon_Pistol";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_StealthPistol";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_MiniCrossbow";
		actors.push(cls); chances.push(1); flags.push(0);

		cls = "DDWeapon_Baton";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_CombatKnife";
		actors.push(cls); chances.push(3); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_Crowbar";
		actors.push(cls); chances.push(2); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_RiotProd";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_Sword";
		actors.push(cls); chances.push(1); flags.push(FLAG_DONTDUP);
		cls = "DDWeapon_PepperGun";
		actors.push(cls); chances.push(1); flags.push(0);


		super.BeginPlay();
	}
}
class DDSpawner_RocketLauncher : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "RocketLauncher";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_GEPGun";
		actors.push(cls); chances.push(12); flags.push(0);
		cls = "DDWeapon_LAW";
		actors.push(cls); chances.push(1); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_WeaponUpgrade_RocketLauncher";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_PlasmaRifle : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "PlasmaRifle";
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_PlasmaRifle";
		actors.push(cls); chances.push(3); flags.push(0);
		cls = "DDWeapon_Flamethrower";
		actors.push(cls); chances.push(5); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_WeaponUpgrade_PlasmaRifle";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}
class DDSpawner_BFG9000 : DDSpawner
{
	default
	{
		DDSpawner.ToReplace "BFG9000";
		DDSpawner.SpawnChance 5;
		DDSpawner.ChanceMul 0.25;
	}
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_Flamethrower";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeapon_LAW";
		actors.push(cls); chances.push(4); flags.push(0);
		cls = "DDWeapon_PlasmaRifle";
		actors.push(cls); chances.push(1); flags.push(0);

		class<DDSpawner> sp = "DDSpawner_WeaponUpgrade_BFG9000";
		spawn_along.push(sp);
		sp = "DDSpawner_DragonsToothSword";
		spawn_along.push(sp);
		super.BeginPlay();
	}
}

class DDSpawner_DragonsToothSword : DDSpawner
{
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeapon_DragonsToothSword";
		actors.push(cls); chances.push(1); flags.push(0);
		super.BeginPlay();
	}
}

/* Weapon mods */
class DDSpawner_WeaponUpgrade : DDSpawner
{
	override void BeginPlay()
	{
		class<Actor> cls = "DDWeaponUpgrade_Accuracy";
		actors.push(cls); chances.push(7); flags.push(0);
		cls = "DDWeaponUpgrade_Clip";
		actors.push(cls); chances.push(7); flags.push(0);
		cls = "DDWeaponUpgrade_Recoil";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeaponUpgrade_Reload";
		actors.push(cls); chances.push(4); flags.push(0);
		cls = "DDWeaponupgrade_Silencer";
		actors.push(cls); chances.push(1); flags.push(0);
		cls = "DDWeaponUpgrade_Laser";
		actors.push(cls); chances.push(1); flags.push(0);

		super.BeginPlay();
	}
}

class DDSpawner_WeaponUpgrade_RocketLauncher : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.SpawnChance 0.35;
		DDSpawner.ChanceMul 0.35;
	}
}
class DDSpawner_WeaponUpgrade_PlasmaRifle : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.SpawnChance 1;
		DDSpawner.ChanceMul 0.3;
	}
}
class DDSpawner_WeaponUpgrade_BFG9000 : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.SpawnChance 1.55;
		DDSpawner.ChanceMul 0.65;
	}
}

class DDSpawner_Soulsphere : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.ToReplace "Soulsphere";
		DDSpawner.SpawnChance 1;
		DDSpawner.ChanceMul 0.3;
		DDSpawner.PreserveItem true;
	}
}
class DDSpawner_Megasphere : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.ToReplace "Megasphere";
		DDSpawner.SpawnChance 2;
		DDSpawner.ChanceMul 0.55;
		DDSpawner.PreserveItem true;
	}
}
class DDSpawner_BlurSphere: DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.ToReplace "BlurSphere";
		DDSpawner.SpawnChance 1.75;
		DDSpawner.ChanceMul 0.45;
		DDSpawner.PreserveItem true;
	}
}
class DDSpawner_Infrared : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.ToReplace "Infrared";
		DDSpawner.SpawnChance 1;
		DDSpawner.ChanceMul 0.2;
		DDSpawner.PreserveItem true;
	}
}

class DDSpawner_Backpack : DDSpawner_WeaponUpgrade
{
	default
	{
		DDSpawner.ToReplace "Backpack";
		DDSpawner.SpawnChance 1.15;
		DDSpawner.ChanceMul 0.35;
	}
	override void BeginPlay()
	{
		let bit = BlockThingsIterator.Create(self, 8);
		while(bit.next()) // don't spawn upgrades on stacked backpacks (think of Doom II's MAP07)
			if(bit.thing is "DDAmmoBox")
				{ spawn_chance = 0; break; }
		let box = DDAmmoBox(Spawn("DDAmmoBox", pos));
		super.BeginPlay();
	}
}

