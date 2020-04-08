class OLChargeBeamEffectGreen extends OLChargeBeamEffect;

defaultproperties
{
	ShockImpactFlareClass=class'OLTeamsShockImpactFlareGreen'
	ShockImpactRingClass=class'OLTeamsShockImpactRingGreen'
	ShockExplosionCoreClass=class'OLTeamsShockExplosionCoreGreen'
	ShockImpactScorchClass=class'OLTeamsShockImpactScorchGreen'

    Begin Object Class=BeamEmitter Name=BeamEmitter0
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_OffsetAsAbsolute
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        AlphaTest=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=192,G=192,R=192))
        ColorScale(1)=(RelativeTime=0.800000,Color=(B=128,G=255,R=128))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        StartLocationOffset=(Y=-12.000000)
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=0.750000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.250000)
        StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=AW-2004Particles.Energy.BeamBolt1a
        LifetimeRange=(Min=0.450000,Max=0.450000)
        Name="BeamEmitter0"
    End Object
    Emitters(0)=BeamEmitter'BeamEmitter0'

    Begin Object Class=BeamEmitter Name=BeamEmitter1
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_OffsetAsAbsolute
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        AlphaTest=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=64,G=64,R=64))
        ColorScale(1)=(RelativeTime=0.800000,Color=(B=128,G=192,R=128))
        ColorScale(2)=(RelativeTime=1.000000)
        Opacity=0.400000
        MaxParticles=1
        StartLocationOffset=(Y=-12.000000)
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=60.000000,Max=60.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=EpicParticles.Flares.SoftFlare
        LifetimeRange=(Min=0.600000,Max=0.600000)
        Name="BeamEmitter1"
    End Object
    Emitters(1)=BeamEmitter'BeamEmitter1'

    Begin Object Class=BeamEmitter Name=BeamEmitter2
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_OffsetAsAbsolute
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        AlphaTest=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=192,G=192,R=192))
        ColorScale(1)=(RelativeTime=0.800000,Color=(B=128,G=255,R=128))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        StartLocationOffset=(Y=12.000000)
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=0.750000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.250000)
        StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=AW-2004Particles.Energy.BeamBolt1a
        LifetimeRange=(Min=0.450000,Max=0.450000)
        Name="BeamEmitter2"
    End Object
    Emitters(2)=BeamEmitter'BeamEmitter2'

    Begin Object Class=BeamEmitter Name=BeamEmitter3
        BeamDistanceRange=(Min=512.000000,Max=512.000000)
        DetermineEndPointBy=PTEP_OffsetAsAbsolute
        RotatingSheets=3
        LowFrequencyPoints=2
        HighFrequencyPoints=2
        BranchProbability=(Max=1.000000)
        BranchSpawnAmountRange=(Max=2.000000)
        UseColorScale=True
        RespawnDeadParticles=False
        AlphaTest=False
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=64,G=64,R=64))
        ColorScale(1)=(RelativeTime=0.800000,Color=(B=128,G=192,R=128))
        ColorScale(2)=(RelativeTime=1.000000)
        Opacity=0.400000
        MaxParticles=1
        StartLocationOffset=(Y=12.000000)
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=60.000000,Max=60.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=EpicParticles.Flares.SoftFlare
        LifetimeRange=(Min=0.600000,Max=0.600000)
        Name="BeamEmitter3"
    End Object
    Emitters(3)=BeamEmitter'BeamEmitter3'
}