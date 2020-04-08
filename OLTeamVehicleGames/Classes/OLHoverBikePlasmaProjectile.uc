class OLHoverBikePlasmaProjectile extends OLPlasmaProjectile;

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
    PlasmaEffectClass=class'Onslaught.ONSPurplePlasmaSmallFireEffect'
    HitEffectClass=class'Onslaught.ONSPlasmaHitPurple'
    Speed=500
    MaxSpeed=7000
    AccelerationMagnitude=16000
    Damage=30
    DamageRadius=190.0
    MyDamageType=class'DamTypeHoverBikePlasma'
}
