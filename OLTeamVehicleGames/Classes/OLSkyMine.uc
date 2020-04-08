class OLSkyMine extends ONSSkyMine;

var byte Team;

var class<Emitter> ShockBallEffectClass[4];
var class<Emitter> ComboEffectClass[4];
var class<Emitter> ComboDecalClass[4];
var() class<ShockBeamEffect> OLBeamEffectClass[4];

replication
{
	reliable if(Role == ROLE_Authority && bNetInitial)
		Team;
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if(Level.NetMode != NM_DedicatedServer)
	{
		if(Team >= 0 && Team < 4)
			ProjectileEffect = spawn(ShockBallEffectClass[Team], self,, Location, Rotation);
		else
			ProjectileEffect = spawn(ProjectileEffectClass, self,, Location, Rotation);
    	
		ProjectileEffect.SetBase(self);
	}
}

simulated function PostBeginPlay()
{
	Super(Projectile).PostBeginPlay();
	
	Velocity = Speed * Vector(Rotation);
	
	if(Role == ROLE_Authority)
		Team = ONSWeapon(Owner).Team;
}

function SuperExplosion()
{
	local actor HitActor;
	local vector HitLocation, HitNormal;
	local Emitter E;

	HurtRadius(ComboDamage, ComboRadius, class'DamTypePRVCombo', ComboMomentumTransfer, Location );

	if(Team >= 0 && Team < 4)
		E = Spawn(ComboEffectClass[Team]);
	else
		E = Spawn(class'ONSPRVComboEffect');
	
	if ( Level.NetMode == NM_DedicatedServer )
	{
		if ( E != None )
			E.LifeSpan = 0.25;
	}
	else if ( EffectIsRelevant(Location,false) )
	{
		HitActor = Trace(HitLocation, HitNormal,Location - Vect(0,0,120), Location,false);
		if ( HitActor != None )
		{
			if(Team >= 0 && Team < 4)
				Spawn(ComboDecalClass[Team],self,,HitLocation, rotator(vect(0,0,-1)));
			else
				Spawn(class'ComboDecal',self,,HitLocation, rotator(vect(0,0,-1)));
		}
	}
	PlaySound(ComboSound, SLOT_None,1.0,,800);
	DestroyTrails();

	if (bDoChainReaction)
	{
		SetPhysics(PHYS_None);
		SetCollision(false);
		bHidden = true;
		SetTimer(ChainReactionDelay, false);
	}
	else
		Destroy();
}

function Timer()
{
	local int x;
	local ShockBeamEffect Beam;
	local Projectile ChainTarget;
	local float BestDist;

	if (OwnerGun != None)
	{
		BestDist = MaxChainReactionDist;
		for (x = 0; x < OwnerGun.Projectiles.length; x++)
		{
			if (OwnerGun.Projectiles[x] == None || OwnerGun.Projectiles[x] == self)
			{
				OwnerGun.Projectiles.Remove(x, 1);
				x--;
			}
			else if (VSize(Location - OwnerGun.Projectiles[x].Location) < BestDist)
			{
				ChainTarget = OwnerGun.Projectiles[x];
				BestDist = VSize(Location - OwnerGun.Projectiles[x].Location);
			}
		}

		if (ChainTarget != None)
		{
			if(Team >= 0 && Team < 4)
				Beam = Spawn(OLBeamEffectClass[Team],,, Location, rotator(ChainTarget.Location - Location));
			else
				Beam = Spawn(BeamEffectClass,,, Location, rotator(ChainTarget.Location - Location));
			
			Beam.Instigator = None;
			Beam.AimAt(ChainTarget.Location, Normal(ChainTarget.Location - Location));
			ChainTarget.TakeDamage(1, Instigator, ChainTarget.Location, vect(0,0,0), ComboDamageType);
		}
	}

	Destroy();
}

defaultproperties
{
	ShockBallEffectClass(0)=class'OLTeamsShockBallRed'
	ShockBallEffectClass(1)=class'OLTeamsShockBallBlue'
	ShockBallEffectClass(2)=class'OLTeamsShockBallGreen'
	ShockBallEffectClass(3)=class'OLTeamsShockBallGold'
	ComboEffectClass(0)=class'OLPRVComboEffectRed'
	ComboEffectClass(1)=class'OLPRVComboEffectBlue'
	ComboEffectClass(2)=class'OLPRVComboEffectGreen'
	ComboEffectClass(3)=class'OLPRVComboEffectGold'
	ComboDecalClass(0)=Class'XEffects.ComboDecal'
	ComboDecalClass(1)=Class'XEffects.ComboDecal'
	ComboDecalClass(2)=Class'XEffects.ComboDecal'
	ComboDecalClass(3)=Class'XEffects.ComboDecal'
	OLBeamEffectClass(0)=Class'OLTeamsRedShockBeamEffect'
	OLBeamEffectClass(1)=Class'OLTeamsBlueShockBeamEffect'
	OLBeamEffectClass(2)=Class'OLTeamsGreenShockBeamEffect'
	OLBeamEffectClass(3)=Class'OLTeamsGoldShockBeamEffect'
}
