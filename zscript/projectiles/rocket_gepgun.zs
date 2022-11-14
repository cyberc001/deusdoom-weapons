class DDProjectile_RocketGEPGun : DDProjectile
{
	default
	{
		Radius 3;
		Height 3;

		Speed 25;
		DDProjectile.GravityZAccel 0.01;
	}

	states
	{
		Spawn:
			DXGR A 1;
			Loop;
	}

	override void DamageVictim(actor victim) {}


	Actor lock_on;
	vector3 accel;

	override void BeginPlay()
	{
		super.BeginPlay();
		accel = (1, 1, 0.65);
	}

	override void Tick()
	{
		super.Tick();
		Spawn("DDAnimatedEffect_SmokeTrail", pos);

		if(lock_on){
			if(CheckSight(lock_on)){
				vector3 vto = Vec3To(lock_on);
				vto.z += lock_on.height * 0.6;
				if(vto.length() != 0) vto /= vto.length();
				vector3 desired_vel = vto * speed;
				A_ChangeVelocity(vel.x < desired_vel.x - accel.x ? accel.x
								: vel.x > desired_vel.x + accel.x ? -accel.x
								: desired_vel.x - vel.x,
								vel.y < desired_vel.y - accel.y ? accel.y
								: vel.y > desired_vel.y + accel.y ? -accel.y
								: desired_vel.y - vel.y,
								vel.z < desired_vel.z - accel.z ? accel.z
								: vel.z > desired_vel.z + accel.z ? -accel.z
								: desired_vel.z - vel.z);
			}
		}
	}

	override void OnDeathStop()
	{
		Spawn("DDAnimatedEffect_ExplosionMedium", pos);
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		DoExplosion(_damage, 112);
		A_StartSound("DDExplosion/medium2", CHAN_AUTO, CHANF_DEFAULT, 1, ATTN_NORM, 1);
		A_SprayDecal(random(0, 1) ? "DDDecal_Scorch1" : "DDDecal_Scorch2");
	}
}
