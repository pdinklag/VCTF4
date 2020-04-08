class OLShockTankProximityExplosionGreen extends ONSShockTankProximityExplosion;

defaultproperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Normal
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.500000,Color=(B=113,G=255,R=113))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=2
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Energy.SmoothRing'
        LifetimeRange=(Min=0.400000,Max=0.400000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=119,G=255,R=119))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=5
        StartLocationShape=PTLS_Polar
        SphereRadiusRange=(Min=32.000000,Max=64.000000)
        StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
        LifetimeRange=(Min=0.500000,Max=0.600000)
        StartVelocityRadialRange=(Min=-200.000000,Max=-250.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=64,G=255,R=64))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=5
        StartLocationShape=PTLS_Polar
        SphereRadiusRange=(Min=32.000000,Max=64.000000)
        StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Particles.Energy.ElecPanels'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.600000)
        StartVelocityRadialRange=(Min=-200.000000,Max=-250.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=187,G=187,R=187))
        ColorScale(2)=(RelativeTime=1.000000)
        MaxParticles=8
        StartLocationShape=PTLS_Polar
        SphereRadiusRange=(Min=32.000000,Max=64.000000)
        StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        InitialParticlesPerSecond=5000.000000
        DrawStyle=PTDS_Darken
        Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
        LifetimeRange=(Min=0.600000,Max=0.700000)
        StartVelocityRadialRange=(Min=-300.000000,Max=-300.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
		DetailMode=DM_High
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        UseColorScale=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=64,G=255,R=64))
        ColorScale(1)=(RelativeTime=0.700000,Color=(B=64,G=255,R=64))
        ColorScale(2)=(RelativeTime=1.000000)
        CoordinateSystem=PTCS_Relative
        MaxParticles=25
        StartLocationOffset=(Z=30.000000)
        StartLocationRange=(X=(Min=-255.000000,Max=225.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-15.000000,Max=15.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=20.000000,Max=50.000000))
        Texture=Texture'AW-2004Particles.Energy.ElecPanels'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
		DetailMode=DM_High
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter10'
}
