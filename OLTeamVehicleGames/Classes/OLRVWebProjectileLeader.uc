class OLRVWebProjectileLeader extends ONSRVWebProjectileLeader;

var class<Emitter> TeamProjectileEffectClass[4];
var class<xEmitter> TeamSparkClass[4];
var byte Team;

replication
{
	reliable if(bNetInitial && Role == ROLE_Authority)
		Team;
}

simulated event PostBeginPlay()
{
	Super(Projectile).PostBeginPlay();
	
	if(Role == ROLE_Authority)
		Team = ONSWeapon(Owner).Team;
	
	FireTime = Level.TimeSeconds;
	Velocity = Speed * Vector(Rotation);

	// On client - add this projectile in next free slot leaders list of projectiles.
	if( Role < ROLE_Authority )
	{
		if(Leader != None && ProjNumber != -1)
		{
			if(Leader.Projectiles.Length < ProjNumber + 1)
				Leader.Projectiles.Length = ProjNumber + 1;

			Leader.Projectiles[ ProjNumber ] = self;
		}
		else
		{
			bNetNotify = true; // We'll need the PostNetReceive to add this projectile to its leader.
		}
	}
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Level.NetMode != NM_DedicatedServer)
	{
		if(Team >= 0 && Team < 4)
			ProjectileEffect = spawn(TeamProjectileEffectClass[Team], self,, Location, Rotation);
		else
			ProjectileEffect = spawn(ProjectileEffectClass, self,, Location, Rotation);
		
		ProjectileEffect.SetBase(self);
	}
}

simulated event Destroyed()
{
	if(Team >= 0 && Team < 4)
		ExplodeEffect = TeamSparkClass[Team];

	Super.Destroyed();
}

defaultproperties
{
	TeamSparkClass(0)=class'SparksRed'
	TeamSparkClass(1)=class'SparksBlue'
	TeamSparkClass(2)=class'GoopSparks'
	TeamSparkClass(3)=class'SparksGold'
	TeamProjectileEffectClass(0)=class'OLRVWebProjectileEffectRed'
	TeamProjectileEffectClass(1)=class'OLRVWebProjectileEffectBlue'
	TeamProjectileEffectClass(2)=class'ONSRVWebProjectileEffect'
	TeamProjectileEffectClass(3)=class'OLRVWebProjectileEffectGold'
}
