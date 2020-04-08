class OLPlasmaProjectile extends ONSPlasmaProjectile abstract;

var class<Emitter> TeamHitEffectClass[4];
var class<Emitter> TeamPlasmaEffectClass[4];

var byte Team;

replication
{
	reliable if(Role == ROLE_Authority)
		Team;
}

simulated event PostBeginPlay()
{
	if(Role == ROLE_Authority)
		Team = Vehicle(Instigator).Team;
	
	Velocity = Speed * Vector(Rotation);
	
	Super(Projectile).PostBeginPlay();
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
    if (Level.NetMode != NM_DedicatedServer)
    {
		if(Team >= 0 && Team < 4)
			Plasma = spawn(TeamPlasmaEffectClass[Team], self,, Location, Rotation);
		else
			Plasma = spawn(PlasmaEffectClass, self,, Location, Rotation);

        Plasma.SetBase(self);
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if ( Role == ROLE_Authority )
        HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );

    if ( EffectIsRelevant(Location,false) )
	{
		if(Team >= 0 && Team < 4)
			Spawn(TeamHitEffectClass[Team],,, HitLocation + HitNormal*5, rotator(-HitNormal));
		else
			Spawn(HitEffectClass,,, HitLocation + HitNormal*5, rotator(-HitNormal));
	}

    PlaySound(Sound'WeaponSounds.BioRifle.BioRifleGoo2');

    Destroy();
}


defaultproperties
{
}
