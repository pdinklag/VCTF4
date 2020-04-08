class OLMASPlasmaProjectile extends OLPlasmaProjectile;

defaultproperties
{
	TeamPlasmaEffectClass(0)=class'ONSRedPlasmaSmallFireEffect'
	TeamPlasmaEffectClass(1)=class'ONSBluePlasmaSmallFireEffect'
	TeamPlasmaEffectClass(2)=class'ONSGreenPlasmaSmallFireEffect'
	TeamPlasmaEffectClass(3)=class'OLGoldPlasmaSmallFireEffect'
	TeamHitEffectClass(0)=class'ONSPlasmaHitRed'
	TeamHitEffectClass(1)=class'ONSPlasmaHitBlue'
	TeamHitEffectClass(2)=class'ONSPlasmaHitGreen'
	TeamHitEffectClass(3)=class'OLPlasmaHitGold'
    PlasmaEffectClass=class'Onslaught.ONSGreenPlasmaSmallFireEffect'
    HitEffectClass=class'Onslaught.ONSPlasmaHitGreen'
    Damage=30
    DamageRadius=100.0
    Speed=500
    MaxSpeed=15000
    AccelerationMagnitude=20000
    MyDamageType=class'DamTypeMASPlasma'
}
