class OLShockTankShockExplosionBlue extends ONSShockTankShockExplosion;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter43
        UseColorScale=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(A=255))
        ColorScale(1)=(RelativeTime=0.500000,Color=(A=255))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=15.000000)
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'EpicParticles.Flares.SoftFlare'
        LifetimeRange=(Min=0.700000,Max=0.700000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter43'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter25
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.100000,Color=(B=64,G=64,R=255))
        ColorScale(2)=(RelativeTime=0.600000,Color=(B=64,G=64,R=255))
        ColorScale(3)=(RelativeTime=1.000000)
        Opacity=0.300000
        FadeOutStartTime=0.555100
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=15.000000)
        StartSizeRange=(X=(Min=60.000000,Max=65.000000),Y=(Min=80.000000,Max=85.000000),Z=(Min=80.000000,Max=85.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'OLTeamVehicleGames.Particles.ShockTankEffectCore2aNoColor'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=1.000000
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter25'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter37
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=176,R=176))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_Darken
        Texture=Texture'AW-2004Particles.Energy.JumpDuck'
        LifetimeRange=(Min=0.600000,Max=0.600000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter37'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter35
        UseColorScale=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=111,R=111))
        ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=85,R=85))
        ColorScale(3)=(RelativeTime=1.000000)
        Opacity=0.500000
        MaxParticles=1
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        InitialParticlesPerSecond=500.000000
        Texture=Texture'AW-2004Particles.Energy.SmoothRing'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter35'

    Begin Object Class=MeshEmitter Name=MeshEmitter10
        StaticMesh=StaticMesh'OLTeamVehicleGames.Particles.PlasmaSphere'
        UseParticleColor=True
        UseColorScale=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=108,R=108))
        ColorScale(1)=(RelativeTime=0.700000,Color=(B=255,G=157,R=157))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        InitialParticlesPerSecond=500.000000
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(4)=MeshEmitter'MeshEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter39
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255))
        ColorScale(2)=(RelativeTime=1.000000)
        Opacity=0.500000
        MaxParticles=1
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_Darken
        Texture=Texture'AW-2004Particles.Weapons.BoloBlob'
        LifetimeRange=(Min=0.600000,Max=0.600000)
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter39'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter36
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=138,R=138))
        ColorScale(1)=(RelativeTime=0.700000,Color=(B=255,G=83,R=83))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=1
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        InitialParticlesPerSecond=2000.000000
        Texture=Texture'AW-2004Particles.Fire.BlastMark'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter36'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=74,R=74))
        ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=108,R=108))
        ColorScale(3)=(RelativeTime=1.000000)
        CoordinateSystem=PTCS_Relative
        MaxParticles=6
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=32.000000,Max=64.000000)
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
        LifetimeRange=(Min=0.500000,Max=0.750000)
        StartVelocityRadialRange=(Min=50.000000,Max=80.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter1'
}
