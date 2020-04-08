class OLVehicleFactory_Leviathan extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSFullAnimations.MASchassis'
	VehicleClass=class'OLMAS'
	RespawnTime=120.0
	TeamBuildEffectClass(0)=class'ONSMASBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSMASBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLMASBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLMASBuildEffectGold'
	NeutralBuildEffectClass=class'OLMASBuildEffectWhite'
}
