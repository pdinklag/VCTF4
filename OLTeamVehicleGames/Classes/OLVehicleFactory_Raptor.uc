class OLVehicleFactory_Raptor extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSVehicles-A.AttackCraft'
	VehicleClass=class'OLAttackCraft'
	TeamBuildEffectClass(0)=class'ONSAttackCraftBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSAttackCraftBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLAttackCraftBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLAttackCraftBuildEffectGold'
	NeutralBuildEffectClass=class'OLAttackCraftBuildEffectWhite'
}
