class OLChargeBeamEffect extends Emitter abstract;

#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

var vector HitLocation;

var class<xEmitter> ShockImpactFlareClass, ShockImpactRingClass, ShockExplosionCoreClass;
var class<xScorch> ShockImpactScorchClass;

replication
{
	reliable if (bNetInitial && Role == ROLE_Authority)
		HitLocation;
}

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Level.NetMode == NM_DedicatedServer)
		LifeSpan = 1.0;
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Role < ROLE_Authority)
		SetupBeam();
}

simulated function SetupBeam()
{
	local BeamEmitter.ParticleBeamEndPoint End;
	local int x;
	local float Dist;
	local PlayerController PC;

	PC = Level.GetLocalPlayerController();
	if ( (PC != None) && !PC.BeyondViewDistance(HitLocation, 0) )
		SpawnEffects(HitLocation, Normal(HitLocation - Location));

	End.Offset.X.Min = HitLocation.X;
	End.Offset.X.Max = HitLocation.X;
	End.Offset.Y.Min = HitLocation.Y;
	End.Offset.Y.Max = HitLocation.Y;
	End.Offset.Z.Min = HitLocation.Z;
	End.Offset.Z.Max = HitLocation.Z;

	Dist = VSize(HitLocation - Location);
	for (x = 0; x < 4; x++)
	{
		BeamEmitter(Emitters[x]).BeamDistanceRange.Min = Dist;
		BeamEmitter(Emitters[x]).BeamDistanceRange.Max = Dist;
		Emitters[x].StartSizeRange.X.Min *= DrawScale;
		Emitters[x].StartSizeRange.Y.Min *= DrawScale;
		Emitters[x].StartSizeRange.X.Max *= DrawScale;
		Emitters[x].StartSizeRange.Y.Max *= DrawScale;
		Emitters[x].LifetimeRange.Min *= DrawScale;
		Emitters[x].LifetimeRange.Max *= DrawScale;
		BeamEmitter(Emitters[x]).BeamEndPoints[0] = End;
	}
}

simulated function SpawnEffects(vector HitLocation, vector HitNormal)
{
	local rotator HitRotation;

	HitRotation = rotator(HitNormal);

	Spawn(ShockImpactFlareClass,,, HitLocation, HitRotation);
	Spawn(ShockImpactRingClass,,, HitLocation, HitRotation);
	Spawn(ShockImpactScorchClass,,, HitLocation, rotator(-HitNormal));
	Spawn(ShockExplosionCoreClass,,, HitLocation+HitNormal*8, HitRotation);
}

defaultproperties
{
	ShockImpactFlareClass=class'ShockImpactFlareB'
	ShockImpactRingClass=class'ShockImpactRingB'
	ShockExplosionCoreClass=class'ShockExplosionCoreB'
	ShockImpactScorchClass=class'ShockImpactScorch'
    AutoDestroy=true
    bNoDelete=false
    RemoteRole=ROLE_SimulatedProxy
    bNetInitialRotation=true
    bNetTemporary=true
}