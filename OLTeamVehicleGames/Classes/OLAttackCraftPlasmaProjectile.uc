class OLAttackCraftPlasmaProjectile extends OLPlasmaProjectile;

defaultproperties
{
    MyDamageType=class'DamTypeAttackCraftPlasma'
	TeamPlasmaEffectClass(0)=class'ONSRedPlasmaFireEffect'
	TeamPlasmaEffectClass(1)=class'ONSBluePlasmaFireEffect'
	TeamPlasmaEffectClass(2)=class'ONSGreenPlasmaFireEffect'
	TeamPlasmaEffectClass(3)=class'OLGoldPlasmaFireEffect'
	TeamHitEffectClass(0)=class'ONSPlasmaHitRed'
	TeamHitEffectClass(1)=class'ONSPlasmaHitBlue'
	TeamHitEffectClass(2)=class'ONSPlasmaHitGreen'
	TeamHitEffectClass(3)=class'OLPlasmaHitGold'
    PlasmaEffectClass=class'Onslaught.ONSRedPlasmaFireEffect'
    HitEffectClass=class'Onslaught.ONSPlasmaHitRed'
    Damage=25
    DamageRadius=200.0
    Speed=1500
    MaxSpeed=12500
    AccelerationMagnitude=24000
}
