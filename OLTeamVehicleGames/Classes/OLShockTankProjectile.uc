class OLShockTankProjectile extends ONSShockTankProjectile;

var class<ONSShockBall> TeamShockBallEffectClass[4];
var class<Emitter> TeamExplosionClass[4];
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
		Team = Vehicle(Instigator).Team;

	Velocity = Speed * Vector(Rotation); // starts off slower so combo can be done closer
    tempStartLoc = Location;
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
	{
		if(Team >= 0 && Team < 4)
			ONSShockBallEffect = Spawn(TeamShockBallEffectClass[Team], self);
		else
			ONSShockBallEffect = Spawn(class'ONSShockBall', self);
		
        ONSShockBallEffect.SetBase(self);
	}
}

function SuperExplosion()
{
	local actor HitActor;
	local vector HitLocation, HitNormal;

	HurtRadius(ComboDamage, ComboRadius, class'DamTypeShockTankShockBall', ComboMomentumTransfer, Location );

	if(Team >= 0 && Team < 4)
		Spawn(TeamExplosionClass[Team]);
	else
		Spawn(class'ONSShockTankShockExplosion');
	
	if ( (Level.NetMode != NM_DedicatedServer) && EffectIsRelevant(Location,false) )
	{
		HitActor = Trace(HitLocation, HitNormal,Location - Vect(0,0,120), Location,false);
		if ( HitActor != None )
			Spawn(class'ComboDecal',self,,HitLocation, rotator(vect(0,0,-1)));
	}
	PlaySound(ComboSound, SLOT_None,1.0,,800);
    DestroyTrails();
    Destroy();
}

defaultproperties
{
	TeamShockBallEffectClass(0)=class'OLShockBallRed'
	TeamShockBallEffectClass(1)=class'OLShockBallBlue'
	TeamShockBallEffectClass(2)=class'OLShockBallGreen'
	TeamShockBallEffectClass(3)=class'OLShockBallGold'
	TeamExplosionClass(0)=class'OLShockTankShockExplosionRed'
	TeamExplosionClass(1)=class'OLShockTankShockExplosionBlue'
	TeamExplosionClass(2)=class'OLShockTankShockExplosionGreen'
	TeamExplosionClass(3)=class'OLShockTankShockExplosionGold'
}
