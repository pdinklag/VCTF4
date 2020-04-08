class OLTurretBeamEffectGold extends ONSTurretBeamEffect;

simulated function SpawnEffects(vector HitLocation, vector HitNormal)
{
	local rotator HitRotation;
	local PlayerController PC;
	local bool bFogDist;
	
	HitRotation = rotator(HitNormal);

	PC = Level.GetLocalPlayerController();
	if ( !PC.BeyondViewDistance(HitLocation, 0) )
	{
		bFogDist = true;
		Spawn(class'OLTeamsShockImpactFlareGold',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockExplosionCoreGold',,, HitLocation+HitNormal*8, HitRotation);
	}
		
	if ( (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 4000) )
	{
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}
	if ( bFogDist && !PC.BeyondViewDistance(HitLocation, 4000) )
	{
		Spawn(class'OLTeamsShockImpactRingGold',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockImpactScorchGold',,, HitLocation, rotator(-HitNormal));
	}	
}

defaultproperties
{
    Begin Object Class=BeamEmitter Name=BeamEmitter4
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_Distance
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        ColorScale(0)=(Color=(B=50,G=128,R=128))
        ColorScale(1)=(RelativeTime=0.800000,Color=(B=100,G=192,R=192,A=128))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        RespawnDeadParticles=False
        AlphaTest=False
        UseRotationFrom=PTRS_Actor
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=30.000000,Max=30.000000))
        InitialParticlesPerSecond=5000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'TurretParticles.Beams.TurretBeam5'
        LifetimeRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Min=500.000000,Max=500.000000))
    End Object
    Emitters(0)=BeamEmitter'BeamEmitter4'
    Begin Object Class=BeamEmitter Name=BeamEmitter5
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_Distance
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        ColorScale(0)=(Color=(R=255,G=255))
        ColorScale(1)=(RelativeTime=0.800000,Color=(R=255,G=255))
        ColorScale(2)=(RelativeTime=1.000000)
        Opacity=0.800000
        MaxParticles=1
        RespawnDeadParticles=False
        AlphaTest=False
        UseRotationFrom=PTRS_Actor
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=30.000000,Max=30.000000))
        InitialParticlesPerSecond=5000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'EpicParticles.Flares.SoftFlare'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=500.000000,Max=500.000000))
    End Object
    Emitters(1)=BeamEmitter'BeamEmitter5'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        ColorScale(0)=(Color=(B=128,G=128,R=128))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64))
        MaxParticles=2
        RespawnDeadParticles=False
        UseRotationFrom=PTRS_Actor
        SpinParticles=True
        StartSpinRange=(X=(Max=1.000000))
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=150.000000,Max=200.000000))
        UniformSize=True
        InitialParticlesPerSecond=2000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'AW-2004Particles.Weapons.PlasmaMuzzleBlue'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter0'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        Acceleration=(Z=20.000000)
        UseColorScale=True
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=55,G=140,R=140))
        ColorScale(2)=(RelativeTime=0.650000,Color=(B=23,G=132,R=132))
        ColorScale(3)=(RelativeTime=1.000000)
        MaxParticles=6
        RespawnDeadParticles=False
        StartLocationOffset=(X=5.000000)
        StartLocationRange=(X=(Max=64.000000),Z=(Min=-8.000000,Max=8.000000))
        UseSizeScale=True
        UseRotationFrom=PTRS_Actor
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=50.000000))
        UniformSize=True
        InitialParticlesPerSecond=2000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        LifetimeRange=(Min=1.500000,Max=1.500000)
        StartVelocityRange=(Z=(Max=15.000000))
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=0.200000
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter1'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseColorScale=True
        ColorScale(0)=(Color=(R=255,G=255))
        ColorScale(1)=(RelativeTime=0.100000,Color=(R=255,G=255))
        ColorScale(2)=(RelativeTime=0.800000,Color=(R=255,G=255))
        ColorScale(3)=(RelativeTime=1.000000)
        MaxParticles=4
        RespawnDeadParticles=False
        StartLocationOffset=(X=10.000000)
        StartLocationRange=(X=(Max=20.000000))
        UseSizeScale=True
        UseRotationFrom=PTRS_Actor
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=40.000000,Max=60.000000))
        UniformSize=True
        InitialParticlesPerSecond=2000.000000
        AutomaticInitialSpawning=False
        Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter2'
}
