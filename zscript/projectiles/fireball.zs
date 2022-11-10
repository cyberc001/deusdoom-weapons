class DDAnimatedProjectile_Fireball : DDAnimatedProjectile
{
	default
	{
		+NOBLOCKMAP;
		+BRIGHT;

		DDAnimatedProjectile.ScaleStart 0.25;
		DDAnimatedProjectile.ScaleEnd 0.65;
		DDAnimatedProjectile.AlphaStart 0.6;
		DDAnimatedProjectile.AlphaEnd 0.1;
		DDAnimatedProjectile.AnimDuration 20;

		Speed 12;
	}

	states
	{
		Spawn:
			DDFB ABCDEFGHIJKLMNOPQRST 1;
			Stop;
		Death:
		XDeath:
		Crash:
			DDFB ABCDEF 1;
			Stop;
	}

	override void DamageVictim(Actor victim){}

	const burn_radius = 24;
	array<Actor> already_damaged;
	override void Tick()
	{
		super.Tick();

		// burn monsters
		BlockThingsIterator itb = BlockThingsIterator.Create(self, burn_radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if(victim == self || !CheckSight(victim) || (!victim.bISMONSTER && !victim.player) || victim == target || already_damaged.Find(victim) != already_damaged.Size())
				continue;

			victim.DamageMobj(self, target, _damage, "Fire");
			already_damaged.Push(victim);
			let existing_burn = victim.FindInventory("DDPowerup_Burn");
			if(!existing_burn){
				let burn = DDPowerup_Burn(Actor.Spawn("DDPowerup_Burn"));
				burn.dmg = _damage;
				victim.addInventory(burn);
			}
		}
	}
}
