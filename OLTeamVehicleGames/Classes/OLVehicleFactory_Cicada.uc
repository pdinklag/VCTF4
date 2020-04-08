class OLVehicleFactory_Cicada extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSBPAnimations.DualAttackCraftMesh'
	VehicleClass=class'OLDualAttackCraft'
	TeamBuildEffectClass(0)=class'ONSAttackCraftBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSAttackCraftBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLAttackCraftBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLAttackCraftBuildEffectGold'
	NeutralBuildEffectClass=class'OLAttackCraftBuildEffectWhite'
}
