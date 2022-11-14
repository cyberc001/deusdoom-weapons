class DDProjectile_WPRocketGEPGun : DDProjectile_RocketGEPGun
{
	const burn_radius = 169;

	override void OnDeathStop()
	{
		super.OnDeathStop();
		// Apply burn to monsters
		BlockThingsIterator itb = BlockThingsIterator.Create(self, burn_radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if(victim == self || !CheckSight(victim) || (!victim.bISMONSTER && !victim.player))
				continue;

			let existing_burn = victim.FindInventory("DDPowerup_Burn");
			if(!existing_burn){
				let burn = DDPowerup_Burn(Actor.Spawn("DDPowerup_Burn"));
				burn.dmg = 15;
				victim.addInventory(burn);
				if(victim.player){
					burn.dur_timer *= 0.3;
					burn.dmg *= 0.3;
				}
				else
					burn.dur_timer *= 2;
			}
		}
		A_SprayDecal(random(0, 1) ? "DDDecal_Scorch1" : "DDDecal_Scorch2");
	}
}
